import 'dart:convert';
import 'package:comrade_bot/api_manager.dart';
import 'package:comrade_bot/api_quests.dart';
import 'package:comrade_bot/slack_api.dart';
import 'package:comrade_bot/slack_event_types.dart';

String API_TOKEN_42;

main() {
  getApiToken().then((value) {
    API_TOKEN_42 = jsonDecode(value)['access_token'];
    getSlackToken().then((noData) {
      botStartup();
    });
  });
}

botStartup() {
  getNextQuest('agissing', API_TOKEN_42).then((value) {
    print(value);
  });
  startingRtm({
    eventTypes.message: onMessage,
    eventTypes.reaction_added: onReaction,
  });
}

onMessage(message) {
  print('MESSAGE :: ');
  print(message);
  String channel = message['channel'];
  String user = message['user'];
  String text = message['text'];
  // user == 'UA05YTMDZ'
  if (user == 'UD3JY1QQ4' || user == 'UD55KN8MU') { 
    if (text == '!ping') {
      sendMessage(
        "pong",
        channel,
        icon_emoji: ':table_tennis_paddle_and_ball:',
        username: 'Pongiste',
      );
    }
  }
}

onReaction(react) {
  print('Reaction ::');
  print(react);
}
