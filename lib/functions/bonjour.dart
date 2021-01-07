import 'package:comrade_bot/slack_api.dart';

void bonjour(channel) {
  sendMessage(
    'Il a pas dit bonjour',
    channel,
    icon_url: 'https://i.ibb.co/4Syg80K/vald.jpg',
    username: 'Vald',
  );
}
