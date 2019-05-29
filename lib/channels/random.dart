import 'dart:convert';

import 'package:comrade_bot/slack_api.dart';

joyjoy(channel, timestamp) {
  addReaction('joyjoy', channel, timestamp);
  sendMessage(":joyjoy:", channel, icon_emoji: ':joyjoy:', username: ':joyjoy:')
      .then(
          (res) => addReaction('joyjoy', channel, jsonDecode(res.body)['ts']));
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
