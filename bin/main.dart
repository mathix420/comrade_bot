import 'dart:io';
import 'dart:convert';
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
    API_TOKEN_42 = jsonDecode(value)['access_token'];
    getSlackToken();
    botStartup();
  });
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
  if (text == null) {
    return;
  }
  // Only for local testing
  if (isDev && isAdmin) {
    if (text.startsWith('!clim')) {
      clim(text, channel);
    } else if (text == '!bonjour') {
      bonjour(channel);
    }
  }
  // Deployed version and access for testing
  if ((channel == 'C8Y2AQR6D' && !isDev) ||
      (isDev && isAdmin && channel != 'C8Y2AQR6D')) {
    if (text.startsWith('!ping')) {
      print('in ping fct');
      ping(text, channel);
    } else if (text.startsWith('!travail')) {
      print('in travail fct');
      travail(text, channel, API_TOKEN_42);
    } else if (text.startsWith('!parrot')) {
      print('in parrot fct');
      parrot(text, channel);
    }
  }
}
