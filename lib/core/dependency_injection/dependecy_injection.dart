import 'package:get_it/get_it.dart';
import 'package:grocery_mart/core/local_db/shared_pref/shared_pref_manager.dart';

final sl = GetIt.I;
Future<void> serviceLocator() async {
  sl.registerSingletonAsync<SharedPreferenceManager>(() async {
    final SharedPreferenceManager sharedPreferenceManager =
        SharedPreferenceManager();
    await sharedPreferenceManager.init();
    return sharedPreferenceManager;
  });
}
