import 'package:comrade_bot/log_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

String PUBLIC;
String PRIVATE;

final int timeOut = 7100;

void getKeys() {
  var envVars = Platform.environment;
  PUBLIC = envVars['INTRA_PUBLIC'];
  PRIVATE = envVars['INTRA_PRIVATE'];
}

void tokenChecker(Function callback) async {
  await Future.delayed(Duration(seconds: timeOut)).then((data) {
    getNewToken().then((String response) {
      callback(response);
      tokenChecker(callback);
    });
  });
}

Future<String> getApiToken() async {
  getKeys();
  return await File('keys/token_42.key').lastModified().then((time) async {
    if (DateTime.now().difference(time).inSeconds >= timeOut) {
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
      dumpToLog(error, 'intra_bad_new_token.log');
      print(error);
      return null;
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
