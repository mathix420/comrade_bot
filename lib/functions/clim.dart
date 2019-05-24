import 'package:comrade_bot/slack_api.dart';

clim(String text, String channel) {
  sendMessage(
    "Reviens plus tard comrade!",
    channel,
    icon_url:
        'https://pm1.narvii.com/6778/3758ad21f6fdbf11bcb3aac5ea181d4132682a74v2_128.jpg',
    username: 'Comrade Worker',
  );
}
