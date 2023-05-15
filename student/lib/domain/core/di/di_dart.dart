import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:student/domain/core/di/di_dart.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureInjection() async {
  await $initGetIt(getIt,environment:Environment.prod);
}
