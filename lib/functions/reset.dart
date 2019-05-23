import 'package:comrade_bot/slack_api.dart';

reset(channel) {
  sendMessage(
    "Avant de reset essaye de vider ton cache :",
    channel,
    jsonAttachement: [
      {
        "text": 'rm -rf "~/Library/Caches/*"',
        "color": "#BC0000",
        "attachment_type": "default",
      }
    ],
    icon_url: "https://pm1.narvii.com/6778/3758ad21f6fdbf11bcb3aac5ea181d4132682a74v2_128.jpg",
    username: 'Comrade 42',
  );
}