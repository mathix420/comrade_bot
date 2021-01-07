import 'package:comrade_bot/functions/class.dart';
import 'package:comrade_bot/handlers.dart';


final helpBlocks = handlers.where((x) => x.help != null).map((content) => ({
  'type': 'section',
  'text': {
    'type': 'mrkdwn',
    'text': content.help
  }
})).toList();

final help = '''
*Display comrade help:*
> `!comrade` or `!help`
''';

var comrade = ComradeCommand(['!comrade', '!help'], help, (channel, message, user) => {
  'message': '',
  'jsonBlocks': [{
    'type': 'section',
    'text': {
      'type': 'mrkdwn',
      'text': 'Privet comrade, here is the man for *Comrade 1.0*:'
    }
  }] + helpBlocks,
}, chans: ['C8Y2AQR6D']);