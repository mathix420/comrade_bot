import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:comrade_bot/slack_api.dart';

final Map<String, String> envVars = Platform.environment;
final YANDEX_KEY = envVars['YANDEX_API'];

final String yandex_url =
    'https://translate.yandex.net/api/v1.5/tr.json/translate?key=$YANDEX_KEY';

final String icon =
    'https://pm1.narvii.com/6778/3758ad21f6fdbf11bcb3aac5ea181d4132682a74v2_128.jpg';

sendResponse(String message, String subMessage, String channel) {
  sendMessage(
    message,
    channel,
    jsonAttachement: [
      {
        "text": subMessage,
        "color": "#BC0000",
        "attachment_type": "default",
      }
    ],
    icon_url: icon,
    username: 'Comrade 42',
  );
}

usageTranslate(String channel) {
  sendResponse(
    "Désolé comrade, il semblerai que tu te sois trompé !\nUtilisation :",
    "`!translate fr-en texte a traduire`",
    channel,
  );
}

Future<String> queryYandex(String slug, String text) async {
  final res = await http.get('$yandex_url&lang=$slug&text=$text');
  if (res.statusCode == 400) {
    return "Bad language code `$slug`!";
  }
  if (res.statusCode != 200) {
    return "Error ${res.statusCode}: bad response from Yandex API.";
  }
  Map<String, dynamic> translation = jsonDecode(res.body);
  if (translation['code'] != 200) {
    return "Error: bad response from Yandex API.\n${translation.toString()}";
  }
  return translation['text'].join('\n');
}

translate(String text, String channel) {
  final List<String> splittedText = text.split(' ');
  final regex = RegExp(r'^[a-z]{2,3}-[a-z]{2,3}$');
  final String mainMessage = "Vodka translator v0.1";
  if (splittedText.length < 3 || !regex.hasMatch(splittedText[1])) {
    usageTranslate(channel);
    return;
  }
  final String translateSlug = splittedText[1];
  final String textToTranslate = splittedText.sublist(2).join(' ');
  queryYandex(translateSlug, textToTranslate).then((translation) {
    sendResponse(mainMessage, translation, channel);
  });
}
