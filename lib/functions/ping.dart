import 'package:comrade_bot/slack_api.dart';

String usagePing() {
  return 'Utilisation :\n`!ping {login 42}`\n`!ping`';
}

void ping(String text, String channel) {
  sendMessage(
    pingMachine(text),
    channel,
    icon_url: 'https://i.ibb.co/61ZtHqL/urssping.png',
    // icon_emoji: ':table_tennis_paddle_and_ball:',
    username: 'Comrade pongiste',
  );
}

String pingMachine(String text) {
  var splittedText = text.split(' ');
  if (splittedText.length > 2) {
    return usagePing();
  }
  final regex = RegExp(r'^[a-zA-Z-]+$');
  if (splittedText.length == 2 && regex.hasMatch(splittedText[1])) {
    return 'pong <@${splittedText[1]}>';
  }
  return 'pong';
}
