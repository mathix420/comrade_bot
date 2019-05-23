import 'package:comrade_bot/api_quests.dart';
import 'package:comrade_bot/slack_api.dart';

final String icon =
    'https://pm1.narvii.com/6778/3758ad21f6fdbf11bcb3aac5ea181d4132682a74v2_128.jpg';

usageTravail(String channel) {
  sendMessage(
    "Désolé comrade, il semblerai que tu te sois trompé !\nUtilisation :",
    channel,
    jsonAttachement: [
      {
        "text": "`!travail <username>`",
        "color": "#BC0000",
        "attachment_type": "default",
      }
    ],
    icon_url: icon,
    username: 'Comrade 42',
  );
}

travail(String text, String channel, String apiToken) {
  List<String> splittedText = text.split(' ');
  final regex = RegExp(r'^[a-zA-Z-]+$');
  if (splittedText.length != 2 || !regex.hasMatch(splittedText[1])) {
    usageTravail(channel);
    return;
  }
  getNextQuest(splittedText[1], apiToken).then((message) {
    sendMessage(
      "Ravi de te revoir comrade !",
      channel,
      jsonAttachement: [
        {
          "text": message,
          "color": "#BC0000",
          "attachment_type": "default",
        }
      ],
      icon_url: icon,
      username: 'Comrade 42',
    );
  });
}
