import 'package:comrade_bot/slack_api.dart';

joyjoy(channel, timestamp) {
  addReaction('joyjoy', channel, timestamp);
  sendMessage(
    ":joyjoy:",
    channel,
    icon_emoji: ':joyjoy:',
    username: ':joyjoy:',
  );
}

randomManager(
  String channel,
  String timestamp,
  String user,
  String text,
  bool isDev,
  bool isAdmin,
) {
  if (text == ':joyjoy:') {
    joyjoy(channel, timestamp);
  }
}
