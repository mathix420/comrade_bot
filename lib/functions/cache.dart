import 'package:comrade_bot/functions/class.dart';

final help = '''
*Clean caches:*
> `!cache` or `!clean`
''';

var cache = ComradeCommand(['!cache', '!clean'], help, (channel, message, user) {
  return '*Be careful:* `rm -r ~/Library/Caches/*; rm ~/.zcompdump*; brew cleanup`';
}, chans: ['C8Y2AQR6D']);