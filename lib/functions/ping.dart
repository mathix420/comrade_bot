import 'package:comrade_bot/functions/class.dart';

String usagePing() {
  return 'Utilisation :\n`!ping {login 42}`\n`!ping`';
}

final ping = ComradeCommand(['!ping'],
  '*Ping slack user:*\n> `!ping` or `!ping <username>`',
  (_, message, user) => pingMachine(message, user),
  chans: ['C8Y2AQR6D'],
  botIcon: 'https://i.ibb.co/61ZtHqL/urssping.png',
  botName: 'Comrade Pongiste'
);

String pingMachine(List<String> args, String user) {
  if (args.length > 2) {
    return usagePing();
  }
  final regex = RegExp(r'^[a-zA-Z-]+$');
  if (args.length == 2 && regex.hasMatch(args[1])) {
    return 'pong <@${args[1]}>';
  }
  return 'pong <@${user}>';
}
