import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> getNextQuest(username, token) async {
  List<int> questOrder = [1, 2, 3, 20, 19];
  String url = 'https://api.intra.42.fr/v2/users/$username/quests_users';
  Map<String, String> header = {"Authorization": "Bearer $token"};
  return await http.get(url, headers: header).then((recievedData) {
    if (recievedData.statusCode != 200) {
      return null;
    }
    List<dynamic> decodedData = jsonDecode(recievedData.body);
    List<Map> sortedData = [];
    if (decodedData.isEmpty) {
      return null;
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
    return sortedData.firstWhere((item) {
      return item['validated_at'] == null;
    });
  });
}
