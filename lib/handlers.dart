// import 'package:comrade_bot/functions/clim.dart';
import 'package:comrade_bot/functions/ping.dart';
import 'package:comrade_bot/functions/class.dart';
import 'package:comrade_bot/functions/cache.dart';
import 'package:comrade_bot/functions/parrot.dart';
import 'package:comrade_bot/functions/comrade.dart';
import 'package:comrade_bot/functions/travail.dart';
import 'package:comrade_bot/functions/bonjour.dart';
import 'package:comrade_bot/functions/ez_utils.dart';
import 'package:comrade_bot/functions/translate.dart';


final handlers = [
  cache,
  ping,
  brew,
  flutter,
  valgrind,
  travail,
  translate,
  bonjour,
  parrot,
  reset,
  norm,
  hello,
  wifi,
  nestor,
  comrade,
];

final handlerTree = treeBuilder(handlers);
