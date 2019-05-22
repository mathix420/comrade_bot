import 'package:http/http.dart' as http;
import 'package:comrade_bot/slack_api.dart';

usageParrot() {
  return "Utilisation :\n`!ping {username}`\n`!ping`";
}

parrot(text, channel) {
  http.get('https://random-ize.com/random-youtube/').then((data) {
    RegExp exp = new RegExp(r'https://www.youtube.com/embed/[^"]*');
    Match matche = exp.firstMatch(data.body);
    if (matche == null) {
      return parrot(text, channel);
    }
    String dest = "https://youtu.be/";
    String res = dest + matche.groups([0])[0].split('/').last;
    sendMessage(
      "$res",
      channel,
      icon_emoji: ':parrotwithmustache:',
      username: 'Parrot',
    );
  });
}
