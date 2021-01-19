import 'package:comrade_bot/global.dart' as g;
import 'package:comrade_bot/slack_types.dart';
import 'package:comrade_bot/api_manager.dart';
import 'package:comrade_bot/slack_api.dart';
import 'package:comrade_bot/handlers.dart';
import 'dart:convert';
import 'dart:io';


final List<String> adminUsers = ['UD3JY1QQ4', 'UD55KN8MU'];
// ['AGISSING', 'KEMARTIN']

void main() {
  Directory('keys').createSync();
  File('keys/token_42.key').createSync();
  getApiToken().then((value) {
    setToken(value);
    tokenChecker(setToken);
    getSlackToken();
    botStartup();
  });
}

void setToken(responseData) {
  g.API_TOKEN_42 = jsonDecode(responseData)['access_token'];
}

void botStartup() {
  startingRtm({
    eventTypes.message: onMessage,
  });
}

void onMessage(message) {
  var channel = message['channel'];
  final user = message['user'];
  final String text = message['text'];

  final isDev = Platform.environment['dev'] == 'true';
  final isAdmin = adminUsers.contains(user);

  if (text == null || user == null) {
    return;
  }

  final args = text.replaceAll(RegExp(r' +'), ' ').split(' ');

  if (isDev && isAdmin) {
    channel = 'C8Y2AQR6D';
  }

  if (handlerTree.containsKey(channel) && handlerTree[channel].containsKey(args[0])) {
    if (isDev && isAdmin) {
      handlerTree[channel][args[0]].checkAndLaunch(message['channel'], args, user);
    } else if (!isDev) {
      handlerTree[channel][args[0]].checkAndLaunch(channel, args, user);
    }
  }
}
