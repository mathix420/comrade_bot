import 'package:comrade_bot/slack_api.dart';

void comradeManual(String channel) {
  var commands = [
    '*Infos about student quests:*\n> !travail <username>',
    '*Translation:*\n> !translate fr-en texte a traduire',
    '*Ping slack user:*\n> !ping <username>',
    '*Ping yourself:*\n> !ping',
    '*Random youtube video:*\n> !parrot',
    '*Install flutter:*\n> !flutter',
    '*Clean caches:*\n> !cache || !clean',
    '*Install brew:*\n> !brew',
    '*Reset your session:*\n> !reset',
    '*Wi-Fi:*\n> !wifi',
  ];
  sendMessage(
    'Privet comrade, voici le manuel d\'utilisation de *Comrade 1.0* :',
    channel,
    jsonBlocks: commands.map((content) => ({
      'type': 'section',
			'text': {
				'type': 'mrkdwn',
				'text': content
			}
    })).toList(),
    icon_url: 'https://pm1.narvii.com/6778/3758ad21f6fdbf11bcb3aac5ea181d4132682a74v2_128.jpg',
    username: 'Comrade 42',
  );
}