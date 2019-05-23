import 'dart:convert';
import 'dart:io';
import 'package:comrade_bot/api_manager.dart';
import 'package:comrade_bot/functions/clim.dart';
import 'package:comrade_bot/functions/parrot.dart';
import 'package:comrade_bot/functions/ping.dart';
import 'package:comrade_bot/functions/travail.dart';
import 'package:comrade_bot/slack_api.dart';
import 'package:comrade_bot/slack_event_types.dart';

String API_TOKEN_42;

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
  // user == 'UA05YTMDZ'
  if (user == 'UD3JY1QQ4' || user == 'UD55KN8MU') {
    if (text.startsWith('!ping')) {
      print('in ping fct');
      ping(text, channel);
    } else if (text.startsWith('!travail')) {
      print('in travail fct');
      travail(text, channel, API_TOKEN_42);
    } else if (text.startsWith('!parrot')) {
      print('in parrot fct');
      parrot(text, channel);
    } else if (text.startsWith('!clim')) {
      clim(text, channel);
    }
  }
}
