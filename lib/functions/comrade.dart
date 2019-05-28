import 'package:comrade_bot/slack_api.dart';

comradeManual(String channel) {
  String travail = "*Infos sur les quests d'un étudiant :*\n> !travail <username>\n";
  String ping1 = "*Ping un utilisateur de slack :*\n> !ping <username>\n";
  String ping2 = "*Se ping sois-même :*\n> !ping\n";
  String parrot = "*Vidéo random de youtube :*\n> !parrot\n";
  String flutter = "*Installation de flutter :*\n> !flutter\n";
  String clean = "*Nettoyage des caches :*\n> !cache";
  sendMessage(
    "Privet comrade, voici le manuel d'utilisation de *Comrade 1.0* :",
    channel,
    jsonAttachement: [
      {
        "text": travail + ping1 + ping2 + parrot + flutter + clean,
        "color": "#BC0000",
        "attachment_type": "default",
      }
    ],
    icon_url: 'https://pm1.narvii.com/6778/3758ad21f6fdbf11bcb3aac5ea181d4132682a74v2_128.jpg',
    username: 'Comrade 42',
  );
}