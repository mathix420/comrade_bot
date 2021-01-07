import 'dart:io';
import 'dart:convert';
import 'package:comrade_bot/functions/class.dart';
import 'package:http/http.dart' as http;
import 'package:comrade_bot/slack_api.dart';

final Map<String, String> envVars = Platform.environment;
final YANDEX_KEY = envVars['YANDEX_API'];

final String yandex_url =
    'https://translate.yandex.net/api/v1.5/tr.json/translate?key=$YANDEX_KEY';

final String icon =
    'https://pm1.narvii.com/6778/3758ad21f6fdbf11bcb3aac5ea181d4132682a74v2_128.jpg';

Map<String, dynamic> formatMessage(String main, String sub) {
  return {
    'message': main,
    'jsonAttachement': [{
      'text': sub,
      'color': '#BC0000',
      'attachment_type': 'default',
    }]
  };
}

Future<String> queryYandex(String slug, String text) async {
  final res = await http.get('$yandex_url&lang=$slug&text=$text');
  if (res.statusCode == 400) {
    return 'Bad language code `$slug`!';
  }
  if (res.statusCode != 200) {
    return 'Error ${res.statusCode}: bad response from Yandex API.';
  }
  Map<String, dynamic> translation = jsonDecode(res.body);
  if (translation['code'] != 200) {
    return 'Error: bad response from Yandex API.\n${translation.toString()}';
  }
  return translation['text'].join('\n');
}

final translate = ComradeCommand(['!translate', '!tr'],
  '*Translation:*\n> `!translate fr-en texte a traduire`',
  (channel, args, user) async {
    final regex = RegExp(r'^[a-z]{2,3}-[a-z]{2,3}$');
    final mainMessage = 'Vodka translator v0.1';

    if (args.length < 3 || !regex.hasMatch(args[1])) {
      return formatMessage(
        'Désolé comrade, il semblerai que tu te sois trompé !\nUtilisation :',
        '`!translate fr-en texte a traduire`'
      );
    }

    final translateSlug = args[1];
    final textToTranslate = args.sublist(2).join(' ');
    final translation = await queryYandex(translateSlug, textToTranslate);

    return formatMessage(mainMessage, translation);
  },
  chans: ['C8Y2AQR6D']
);