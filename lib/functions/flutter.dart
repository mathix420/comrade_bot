import 'package:comrade_bot/slack_api.dart';

flutter(channel) {
  sendMessage(
    "Bonne chance comrade\n```curl --silent https://raw.githubusercontent.com/mathix420/flutter_installer/master/flutter_install.sh | zsh```",
    channel,
    icon_url: 'https://pm1.narvii.com/6778/3758ad21f6fdbf11bcb3aac5ea181d4132682a74v2_128.jpg',
    username: 'Comrade 42',
  );
}