import 'package:comrade_bot/slack_api.dart';

void brew(channel) {
  sendMessage(
    'Davaï `rm -rf \$HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew \$HOME/.brew && export PATH=\$HOME/.brew/bin:\$PATH && brew update && echo "export PATH=\$HOME/.brew/bin:\$PATH" >> ~/.zshrc`',
    channel,
    icon_url: 'https://pm1.narvii.com/6778/3758ad21f6fdbf11bcb3aac5ea181d4132682a74v2_128.jpg',
    username: 'Comrade 42',
  );
}

void flutter(channel) {
  sendMessage(
    'Bonne chance comrade\n`curl --silent https://raw.githubusercontent.com/mathix420/flutter_installer/master/flutter_install.sh | zsh`',
    channel,
    icon_url: 'https://pm1.narvii.com/6778/3758ad21f6fdbf11bcb3aac5ea181d4132682a74v2_128.jpg',
    username: 'Comrade 42',
  );
}

void reset(channel) {
  sendMessage(
    'Reset: `touch ~/.reset`\nReset library: `touch ~/.reset_library`\nThen logout and login again.',
    channel,
    icon_url: 'https://pm1.narvii.com/6778/3758ad21f6fdbf11bcb3aac5ea181d4132682a74v2_128.jpg',
    username: 'Comrade 42',
  );
}

void hello(channel) {
  sendMessage(
    'Here to serve you comrade, type `!comrade`.',
    channel,
    icon_url: 'https://pm1.narvii.com/6778/3758ad21f6fdbf11bcb3aac5ea181d4132682a74v2_128.jpg',
    username: 'Comrade 42',
  );
}

void wifi(channel) {
  sendMessage(
    'Stay connected comrade http://wifi.42.fr.',
    channel,
    icon_url: 'https://pm1.narvii.com/6778/3758ad21f6fdbf11bcb3aac5ea181d4132682a74v2_128.jpg',
    username: 'Comrade 42',
  );
}