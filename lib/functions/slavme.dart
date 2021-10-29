import 'package:comrade_bot/functions/class.dart';
import 'package:comrade_bot/slack_types.dart';
import 'package:comrade_bot/slack_api.dart';

final BASE_URL = 'https://comrade-picture.herokuapp.com';

final slavme = ComradeCommand(['!slavme'], '*Make student more slavic:*\n> `!slavme [0-2] <username>`', (channel, args, user) async {
  if (args.length < 2 || (int.tryParse(args[1]) ?? -1) < 0 || (int.tryParse(args[1]) ?? -1) > 2) {
    return 'Please choose an id between 0 and 2.';
  }
  if (args.length < 3) {
    args.add(await getUserFormUid(user));
  }
  return '${BASE_URL}/image/${args[1]}/${args[2]}/comrade.jpg';
}, chans: [slackChannels['tools_bots']]);
