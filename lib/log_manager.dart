import 'dart:io';
import 'dart:convert';

dumpToLog(dynamic jsonCompatibleVar, String logName) async {
  var logDir = Directory('logs');
  var logFile = File('logs/' + logName);
  if (!logDir.existsSync()) {
    logDir.createSync();
  }
  if (!logFile.existsSync()) {
    logFile.createSync();
  }
  String logData = '=' * 100 + '\n';
  logData += DateTime.now().toIso8601String() + '\t';
  logData += jsonEncode(jsonCompatibleVar) + '\n\n';
  await logFile.writeAsString(logData, mode: FileMode.append);
}