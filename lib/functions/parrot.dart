import 'package:comrade_bot/functions/class.dart';
import 'package:http/http.dart' as http;

int count = 0;

Future<String> rndVideo() async {
  count += 1;
  if (count >= 10) {
    return 'Sorry no videos for now :sad_blob:';
  }

  return http.get(Uri.parse('https://random-ize.com/random-youtube/')).then((data) {
    final exp = RegExp(r'https://www.youtube.com/embed/[^"]*');
    Match match = exp.firstMatch(data.body);

    if (match == null) {
      return rndVideo();
    }

    return 'https://youtu.be/' + match.groups([0])[0].split('/').last;
  });
}

final parrot = ComradeCommand(['!parrot'],
  '*Random youtube video:*\n> `!parrot`',
  (channel, args, user) async {
    count = 0;
    return {
      'message': await rndVideo(),
      'icon_emoji': ':parrot:'
    };
  },
  chans: ['C8Y2AQR6D'],
  botName: 'Comrade Parrot',
);