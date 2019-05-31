import 'dart:io';
import 'dart:convert';
import 'package:comrade_bot/functions/comrade.dart';
import 'package:comrade_bot/functions/flutter.dart';
import 'package:comrade_bot/functions/cache.dart';
import 'package:comrade_bot/slack_api.dart';
import 'package:comrade_bot/api_manager.dart';
import 'package:comrade_bot/functions/clim.dart';
import 'package:comrade_bot/functions/ping.dart';
import 'package:comrade_bot/functions/parrot.dart';
import 'package:comrade_bot/functions/travail.dart';
import 'package:comrade_bot/slack_event_types.dart';
import 'package:comrade_bot/functions/bonjour.dart';

String API_TOKEN_42;

final List<String> adminUsers = ['UD3JY1QQ4', 'UD55KN8MU'];

main() {
  Directory('keys').createSync();
  File('keys/token_42.key').createSync();
  getApiToken().then((value) {
    setToken(value);
    tokenChecker(setToken);
    getSlackToken();
    botStartup();
  });
}

setToken(responseData) {
  API_TOKEN_42 = jsonDecode(responseData)['access_token'];
}

botStartup() {
  startingRtm({
    eventTypes.message: onMessage,
  });
}

onMessage(message) {
  String channel = message['channel'];
  String user = message['user'];
  String text = message['text'];
  bool isDev = Platform.environment['dev'] == 'true';
  bool isAdmin = adminUsers.contains(user);
  if (text == null || user == null) {
    return;
  }
  // Work in progress
  if (isDev && isAdmin) {
    if (text.startsWith('!clim')) {
      clim(text, channel);
    } else if (text == '!bonjour') {
      bonjour(channel);
    }
  }
  // Only released features
  if ((channel == 'C8Y2AQR6D' && !isDev) ||
      (isDev && isAdmin && channel != 'C8Y2AQR6D')) {
    if (text.startsWith('!ping')) {
      ping(text, channel);
    } else if (text.startsWith('!travail')) {
      travail(text, channel, API_TOKEN_42, getUserFormUid(user));
    } else if (text.startsWith('!parrot')) {
      parrot(text, channel);
    } else if (text == '!comrade') {
      comradeManual(channel);
    } else if (text == '!flutter') {
      flutter(channel);
    } else if (text == '!cache' || text == '!clean') {
      cache(channel);
    }
  }
}
