import 'package:http/http.dart' as http;
import 'package:comrade_bot/slack_api.dart';

String usageParrot() {
  return 'Utilisation :\n`!ping {username}`\n`!ping`';
}

void parrot(text, channel) {
  http.get('https://random-ize.com/random-youtube/').then((data) {
    var exp = RegExp(r'https://www.youtube.com/embed/[^"]*');
    Match matche = exp.firstMatch(data.body);
    if (matche == null) {
      return parrot(text, channel);
    }
    var dest = 'https://youtu.be/';
    var res = dest + matche.groups([0])[0].split('/').last;
    sendMessage(
      '$res',
      channel,
      icon_emoji: ':parrotwithmustache:',
      username: 'Parrot',
    );
  });
}
