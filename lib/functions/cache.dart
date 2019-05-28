import 'package:comrade_bot/slack_api.dart';

cache(channel) {
  sendMessage(
    '*Be careful:* `rm -r ~/Library/Caches/*; rm ~/.zcompdump*; brew cleanup`',
    channel,
    icon_url: "https://pm1.narvii.com/6778/3758ad21f6fdbf11bcb3aac5ea181d4132682a74v2_128.jpg",
    username: 'Comrade 42',
  );
}
