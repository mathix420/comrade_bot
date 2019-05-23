import 'dart:io';

portBinder() async {
  Map<String, String> envVars = Platform.environment;

 var server = await HttpServer.bind(InternetAddress.loopbackIPv4, int.parse(envVars['PORT']));
  print("Serving at ${server.address}:${server.port}");

  await for (var request in server) {
    request.response
      ..headers.contentType = new ContentType("text", "plain", charset: "utf-8")
      ..write('Hello Comrade!');
      await request.response.close();
  }
}
