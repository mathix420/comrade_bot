import 'package:html_unescape/html_unescape.dart';
import 'package:comrade_bot/functions/class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

final Map<String, String> envVars = Platform.environment;
final MYMEMORY_SECRET = envVars['MYMEMORY_SECRET'];
final unescape = HtmlUnescape();
final String endpoint =
    'https://translated-mymemory---translation-memory.p.rapidapi.com/api/get?mt=1';

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

Future<String> queryAPI(String slug, String text) async {
  final res = await http.get('$endpoint&langpair=$slug&q=$text',
  headers: {
    'x-rapidapi-key': MYMEMORY_SECRET,
    'x-rapidapi-host': 'translated-mymemory---translation-memory.p.rapidapi.com'
  });
  if (res.statusCode == 400) {
    return 'Bad language code `$slug`!';
  }
  if (res.statusCode != 200) {
    return 'Error ${res.statusCode}: bad response from MyMemory API.';
  }
  Map<String, dynamic> translation = jsonDecode(res.body);
  if (translation['responseStatus'] != 200) {
    return 'Error: bad response from MyMemory API.\n${translation.toString()}';
  }
  return unescape.convert(translation['responseData']['translatedText']);
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

    final translateSlug = args[1].replaceFirst('-', '|');
    final textToTranslate = args.sublist(2).join(' ');
    final translation = await queryAPI(translateSlug, textToTranslate);

    return formatMessage(mainMessage, translation);
  },
  chans: ['C8Y2AQR6D']
);