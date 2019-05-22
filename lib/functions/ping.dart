import 'package:comrade_bot/slack_api.dart';

usagePing() {
  return "Utilisation :\n`!ping {username}`\n`!ping`";
}

ping(text, channel) {
  sendMessage(
    "pong",
    channel,
    icon_emoji: ':table_tennis_paddle_and_ball:',
    username: 'Pongiste',
  );
}
