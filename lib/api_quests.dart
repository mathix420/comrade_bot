import 'package:comrade_bot/log_manager.dart';
import 'package:comrade_bot/global.dart' as g;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

final INTRA_SESSION = Platform.environment['INTRA_SESSION'];

// Messages
String BH_MSG(username) => '''Comrade tes efforts on été vaint, tu as fini au goulag.
:rip: :rip: :rip: :rip: :rip: :rip:
<@$username>
:rip: :rip: :rip: :rip: :rip: :rip:''';

String LAST_DAY_MSG(nextQuest) => '''Prochnost comrade :muscle:
C'est ton dernier jour pour valider _${nextQuest['quest']['name']}_ avant le prochain round!''';

String DEFAULT_MSG(time, nextQuest, todo) => '''Encore *$todo quest${todo > 1 ? 's' : ''}* à valider...
Prochaine étape : _${nextQuest['quest']['name']}_
Vous avez *$time jour${time > 1 ? 's' : ''}* pour atteindre cette étape
Sinon :arrow_right::blackhole: alors davaï comrade!''';

final SPE_MESSAGES = {
  59: '''Due to COVID-19 you're allowed to play with outer circle. :parrotbeer:
But don't worry once the virus is done you will need to validate them. :risitas:''',
};

final QUESTS = {
  // Cursus `42`
  1: [1, 2, 3, 20, 19],
  // Cursus `42cursus`
  21: [50, 44, 45, 37],
};


Future<dynamic> queryIntra(String username) {
  final url = Uri.parse('https://api.intra.42.fr/v2/users/$username/quests_users');
  final header = {'Authorization': 'Bearer ${g.API_TOKEN_42}'};

  return http.get(url, headers: header).then((data) {
    if (data.statusCode != 200) {
      dumpToLog(data.body, 'not_found_user.log');
      return Future.error('I can\'t find *$username* in my registers!');
    }
    if (data.body.isEmpty) {
      return Future.error('An error occurred!\nAll our agents are on it!');
    }

    return jsonDecode(data.body);
  }).catchError((err) => Future.error(err));
}

Future<int> getBHDate(String username) {
  final url = Uri.parse('https://profile.intra.42.fr/users/$username/goals?cursus=42cursus');
  final header = {'Cookie': '_intra_42_session_production=$INTRA_SESSION'};

  return http.get(url, headers: header).then((data) {
    if (data.statusCode != 200 || data.body.isEmpty) {
      return Future.error('An error occurred!\nAll our agents are on it!');
    }
    final j = jsonDecode(data.body);
    return j['singularity'];
  });
}

Future<Map> getNextQuest(String username) async {
  return await queryIntra(username).then((j) async {
    final cursusId = j.reduce((a, b) => a['quest']['cursus_id'] == 21 ? a : b)['quest']['cursus_id'];

    // Get only quests from latest cursus
    j.retainWhere((v) => v['quest']['cursus_id'] == cursusId);
    j = j.toSet().toList();

    // Sort j by QUESTS positions
    j.sort((a, b) => QUESTS[cursusId].indexOf(a['quest_id']).compareTo(QUESTS[cursusId].indexOf(b['quest_id'])));
    final lastDoneQuest = j.lastWhere((v) => v['validated_at'] != null);
    final todo = QUESTS[cursusId].length - QUESTS[cursusId].indexOf(lastDoneQuest['quest_id']) - 1;

    print(json.encode(j));

    if (SPE_MESSAGES.containsKey(lastDoneQuest['quest_id'])) {
      return { 'ok': true, 'message': SPE_MESSAGES[lastDoneQuest['quest_id']] };
    } else if (todo == 0) { // || lastDoneQuest['quest_id'] == 50
      return {
          'ok': true,
          'message': 'Bon travail comrade, tu as validé toutes tes quests! :party-frog:'
        };
    }

    final nextQuest = j[j.indexOf(lastDoneQuest) + 1];
    int time;

    if (nextQuest['end_at'] != null) {
      final end = DateTime.parse(nextQuest['end_at']);
      time = end.difference(DateTime.now()).inDays;
    } else {
      try {
        time = await getBHDate(username);
      } catch (e) {
        return Future.error(e);
      }
    }

    if (time < 0) {
      return {
        'ok': true,
        'message': BH_MSG(username)
      };
    } else if (time == 0 && todo != 0) {
      return {
        'ok': true,
        'message': LAST_DAY_MSG(lastDoneQuest)
      };
    }

    return {
        'ok': true,
        'message': DEFAULT_MSG(time, nextQuest, todo)
      };
  }).catchError((err) {
    return { 'ok': false, 'message': err.toString() };
  });
}
