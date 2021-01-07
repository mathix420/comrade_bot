import 'package:comrade_bot/functions/class.dart';
import 'package:comrade_bot/global.dart' as g;
import 'package:comrade_bot/api_quests.dart';
import 'package:comrade_bot/slack_api.dart';


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

final travail = ComradeCommand(['!travail'],
  '*Infos about student quests:*\n> `!travail <username>`',
  (channel, args, user) async {
    final futureName = getUserFormUid(user);
    final regex = RegExp(r'^[a-zA-Z-]+$');
    var mainMessage = 'Ravi de te revoir comrade !';
    if (args.length != 2 || !regex.hasMatch(args[1])) {
      return formatMessage(
        'Désolé comrade, il semblerai que tu te sois trompé !\nUtilisation :',
        '`!travail <username>`'
      );
    }
    final result = await getNextQuest(args[1], g.API_TOKEN_42);
    final name = await futureName;
    if (result['ok'] && name != args[1]) {
      mainMessage = 'Devrai-je prévenir comrade <@${args[1]}>?';
    }
    return formatMessage(mainMessage, result['message']);
  },
  chans: ['C8Y2AQR6D']
);
