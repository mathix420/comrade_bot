import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> getNextQuest(username, token) async {
  List<int> questOrder = [1, 2, 3, 20, 19];
  String url = 'https://api.intra.42.fr/v2/users/$username/quests_users';
  Map<String, String> header = {"Authorization": "Bearer $token"};
  return await http.get(url, headers: header).then((recievedData) {
    if (recievedData.statusCode != 200) {
      return 'Je ne trouve pas *$username* dans les registres !';
    }
    List<dynamic> decodedData = jsonDecode(recievedData.body);
    List<Map> sortedData = [];
    if (decodedData.isEmpty) {
      return 'Une erreur c\'est produite !\nTout nos agents sont sur le coup !';
    }
    decodedData.forEach((quest) {
      if (questOrder.contains(quest['quest_id'])) {
        sortedData.add(quest);
      }
    });
    if (sortedData.isNotEmpty) {
      sortedData.sort((item1, item2) {
        return questOrder
            .indexOf(item1['quest_id'])
            .compareTo(questOrder.indexOf(item2['quest_id']));
      });
      sortedData.removeWhere((it) {
        int id = sortedData.indexWhere((item) {
          return item['quest_id'] == it['quest_id'] &&
              item['validated_at'] != null;
        });
        return id != -1 && it['validated_at'] == null;
      });
    }
    if (sortedData.last['validated_at'] != null) {
      return "Bon travail comrade, tu as validé toutes tes quests! :party-frog:";
    }
    Map nextQuest = sortedData.firstWhere((item) {
      return item['validated_at'] == null;
    });
    int todo = sortedData.length - (sortedData.indexOf(nextQuest));

    if (nextQuest['end_at'] != null) {
      var end = DateTime.parse(nextQuest['end_at']);
      var time = end.difference(DateTime.now()).inDays;

      return """Encore *$todo quest${todo > 1 ? 's' : ''}* à valider...
Prochaine étape : _${nextQuest['quest']['name']}_\nVous avez *$time jour${time > 1 ? 's' : ''}* pour atteindre cette étape
Davaï comrade!""";
    }
    return """Il te reste encore *$todo quest${todo > 1 ? 's' : ''}* à valider, mais tu as passé tous les :blackhole: !
Prochaine étape : _${nextQuest['quest']['name']}_\nBonne chance comrade!""";
  });
}
