import 'package:comrade_bot/api_quests.dart';
import 'package:comrade_bot/slack_api.dart';

final String icon =
    'https://pm1.narvii.com/6778/3758ad21f6fdbf11bcb3aac5ea181d4132682a74v2_128.jpg';

Map<String, List<String>> easterEggs = {
};

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

usageTravail(String channel) {
  sendResponse(
    "Désolé comrade, il semblerai que tu te sois trompé !\nUtilisation :",
    "`!travail <username>`",
    channel,
  );
}

travail(String text, String channel, String apiToken, userRequest) {
  List<String> splittedText = text.split(' ');
  final regex = RegExp(r'^[a-zA-Z-]+$');
  String mainMessage = "Ravi de te revoir comrade !";
  if (splittedText.length != 2 || !regex.hasMatch(splittedText[1])) {
    usageTravail(channel);
    return;
  }
  getNextQuest(splittedText[1], apiToken).then((result) {
    userRequest.then((name) {
      if (result['ok'] && name != splittedText[1]) {
        mainMessage = "Devrai-je prévenir comrade <@${splittedText[1]}>?";
      }
      sendResponse(mainMessage, result['message'], channel);
    });
  });
}
