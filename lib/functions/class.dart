import 'package:comrade_bot/slack_types.dart';
import 'package:comrade_bot/slack_api.dart';

Map<String, Map<String, ComradeCommand>> treeBuilder(List<ComradeCommand> handlers) {
  var output = <String, Map<String, ComradeCommand>>{};
  handlers.forEach((handler) {
    handler.channels.forEach((channel) {
      output.putIfAbsent(channel, () => <String, ComradeCommand>{});
      handler.commands.forEach((command) {
        output[channel].putIfAbsent(command, () => handler);
      });
    });
  });
  return output;
}

class ComradeCommand {
  String icon = 'https://pm1.narvii.com/6778/3758ad21f6fdbf11bcb3aac5ea181d4132682a74v2_128.jpg';
  Function(String channel, List<String> message, String user) handler;
  List<String> channels = [slackChannels['tools_bots']];
  String disaplayName = 'Comrade 42';
  List<String> commands;
  String help;

  ComradeCommand(this.commands, this.help, this.handler, {List<String> chans, botIcon, botName}) {
    if (chans != null && chans.isNotEmpty) {
      channels = chans;
    }
    if (botIcon != null) {
      icon = botIcon;
    }
    if (botName != null) {
      disaplayName = botName;
    }
  }

  Future<void> checkAndLaunch(String channel, List<String> message, String user) async {
    String msg;

    if (!commands.contains(message[0])) {
      return ;
    }

    var data = await handler(channel, message, user);

    if (data == null) {
      return ;
    } else if (data is String) {
      msg = data;
      data = {};
    } else {
      msg = data['message'];
      data.remove('message');
      
      data = data.map((k, v) => MapEntry(Symbol(k), v));
    }

    await Function.apply(sendMessage, [msg, channel], {
      #icon_url: icon,
      #username: disaplayName,
      ...data
    });
  }
}