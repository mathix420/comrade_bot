import 'package:http/http.dart' as http;
import 'slack_types.dart';
import 'dart:convert';
import 'dart:io';

String API_TOKEN;

// Slack API for RTM

Map<eventTypes, Function> functionWrapper = {};

void getSlackToken() {
  var envVars = Platform.environment;
  API_TOKEN = envVars['SLACK_PRIVATE'];
}

void startingRtm([Map<eventTypes, Function> functions]) async {
  if (functions.isNotEmpty) {
    functionWrapper.addAll(functions);
  }
  await HttpClient()
      .getUrl(Uri.parse('https://slack.com/api/rtm.connect?token=$API_TOKEN'))
      .then((HttpClientRequest request) => request.close())
      .then((HttpClientResponse response) async {
    response.transform(utf8.decoder).listen((contents) async {
      if (response.statusCode != 200) {
        print('Error: Bad response code: ${response.statusCode}!');
        return;
      }
      Map responseData = jsonDecode(contents);
      if (responseData['ok'] == 'false') {
        print('Error when trying to connect to websocket!');
        return;
      }
      var socket = await WebSocket.connect(responseData['url']);
      socket.listen(slackListener,
          onError: slackSocketError, onDone: startingRtm);
    });
  });
}

void slackSocketError(error) {
  print('Error: An error occurs in Slack socket!');
  print(error.toString());
}

void slackListener(receiveData) {
  Map dataInfos = jsonDecode(receiveData);
  functionWrapper.forEach((type, function) {
    if (dataInfos['type'] == eventTypesString[type.index]) {
      function(jsonDecode(receiveData));
    }
  });
}

void addReaction(String emoji, String channel, String timestamp) {
  final reqUrl = 'https://slack.com/api/reactions.add?token=$API_TOKEN';
  dynamic requestBody = {
    'name': emoji,
    'channel': channel,
    'timestamp': timestamp
  };
  http.post(reqUrl, body: requestBody);
}

// Slack API for sending messages
Future<dynamic> sendMessage(String message, String channel, {
    bool as_user = false,
    dynamic jsonAttachement,
    dynamic jsonBlocks,
    String icon_emoji,
    String icon_url,
    String link_names,
    String markdown,
    String parse,
    bool reply_broadcast = false,
    double thread_ts,
    bool unfurl_links = false,
    bool unfurl_media = true,
    String username
  }) async {
  final requestUrl = 'https://slack.com/api/chat.postMessage?token=$API_TOKEN';
  dynamic requestBody = {
    'text': message,
    'channel': channel,
    'as_user': as_user.toString(),
    'reply_broadcast': reply_broadcast.toString(),
    'unfurl_links': unfurl_links.toString(),
    'unfurl_media': unfurl_media.toString(),
    'username': username,
  };
  if (jsonAttachement != null) {
    requestBody['attachments'] = jsonEncode(jsonAttachement);
  }
  if (jsonBlocks != null) {
    requestBody['blocks'] = jsonEncode(jsonBlocks);
  }
  if (thread_ts != null) {
    requestBody['thread_ts'] = thread_ts;
  }
  if (icon_emoji != null) {
    requestBody['icon_emoji'] = icon_emoji;
  }
  if (icon_url != null) {
    requestBody['icon_url'] = icon_url;
  }
  if (link_names != null) {
    requestBody['link_names'] = link_names;
  }
  if (markdown != null) {
    requestBody['markdown'] = markdown;
  }
  if (parse != null) {
    requestBody['parse'] = parse;
  }
  return await http.post(requestUrl, body: requestBody);
}

// GET Username from UID
Future<dynamic> getUserFormUid(String uid) async {
  final url = Uri.parse('https://slack.com/api/users.info?token=$API_TOKEN&user=$uid');
  return await http.get(url).then((response) {
    if (response != null && response.body != null) {
      return jsonDecode(response.body)['user']['name'];
    } else {
      return null;
    }
  });
}
