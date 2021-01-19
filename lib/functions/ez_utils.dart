import 'package:comrade_bot/functions/class.dart';
import 'package:comrade_bot/slack_types.dart';

final chans = [slackChannels['tools_bots']];

final brew = ComradeCommand(['!brew'], '*Install Brew:*\n> `!brew`', (channel, message, user) {
  return 'Davaï `rm -rf \$HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew \$HOME/.brew && export PATH=\$HOME/.brew/bin:\$PATH && brew update && echo "export PATH=\$HOME/.brew/bin:\$PATH" >> ~/.zshrc`';
}, chans: chans);

final valgrind = ComradeCommand(['!valgrind'], '*Install Valgrind:*\n> `!valgrind`', (channel, message, user) {
  return '`brew update && brew install valgrind && alias valgrind="~/.brew/bin/valgrind"`';
}, chans: chans);

final flutter = ComradeCommand(['!flutter'], '*Install Flutter:*\n> `!flutter`', (channel, message, user) {
  return 'Bonne chance comrade\n`curl --silent https://raw.githubusercontent.com/mathix420/flutter_installer/master/flutter_install.sh | zsh`';
}, chans: chans);

final reset = ComradeCommand(['!reset'], '*Reset your session:*\n> `!reset`', (channel, message, user) {
  return 'Reset: `touch ~/.reset`\nReset library: `touch ~/.reset_library`\nThen logout and login again.';
}, chans: chans);

final hello = ComradeCommand(['!bot'], null, (channel, message, user) {
  return 'Here to serve you comrade, type `!comrade`.';
}, chans: chans);

final wifi = ComradeCommand(['!wifi'], '*Wi-Fi:*\n> `!wifi`', (channel, message, user) {
  return 'Stay connected comrade http://wifi.42.fr.';
}, chans: chans);

final norm = ComradeCommand(['!norm'], '*Norm PDF:*\n> `!norm`', (channel, message, user) {
  return '<https://cdn.intra.42.fr/pdf/pdf/317/norme.fr.pdf|Miaou, clique ici pour la Norme 2.0.2 🇫🇷> • <https://cdn.intra.42.fr/pdf/pdf/1065/norme.en.pdf|Meow, click here for Norm 2.0.2 🇺🇸>';
}, chans: chans, botIcon: 'https://cdn.intra.42.fr/users/small_norminet.jpg');

final nestor = ComradeCommand(['!nestor'], '*Nestor discount:*\n> `!nestor`', (channel, message, user) {
  return '<https://nestorparis.com/?sponsorshipCode=waPwf|Get 4€ on your first command!> :chef2:';
}, chans: chans);