import 'dart:io';
import 'package:http/http.dart' as http;

String PUBLIC;
String PRIVATE;

Future getTokens() async {
  return await File('keys/token_intra.key').readAsLines().then((tokens) {
    PUBLIC = tokens[0].trim();
    PRIVATE = tokens[1].trim();
    return;
  });
}

Future<String> getApiToken() async {
  return await getTokens().then((noData) async {
    return await File('keys/token_42.key').lastModified().then((time) async {
      if (DateTime.now().difference(time).inSeconds >= 7100) {
        return getNewToken();
      }
      return await File('keys/token_42.key')
          .readAsString()
          .then((String contents) {
        if (contents.isNotEmpty) {
          return (contents);
        }
        return getNewToken();
      }).catchError((error) {
        // TODO: errors in log
        print(error);
        return null;
      });
    });
  });
}

void setApiToken(String token) {
  File('keys/token_42.key').writeAsString(token);
}

Future<String> getNewToken() async {
  return await http.post(
    'https://api.intra.42.fr/oauth/token',
    body: {
      'grant_type': 'client_credentials',
      'client_id': PUBLIC,
      'client_secret': PRIVATE,
    },
  ).then((result) {
    setApiToken(result.body);
    return result.body;
  }).catchError((error) {
    print(error);
    return null;
  });
}
