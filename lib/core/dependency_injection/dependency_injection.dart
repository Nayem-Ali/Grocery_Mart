import 'package:get_it/get_it.dart';
import 'package:grocery_mart/core/local_db/shared_pref/shared_pref_manager.dart';
import 'package:grocery_mart/data/services/local/cart_services.dart';
import 'package:grocery_mart/data/services/local/product_services.dart';
import 'package:grocery_mart/features/cart/controller/cart_bloc.dart';
import 'package:grocery_mart/features/products/controller/product_bloc.dart';

final GetIt sl = GetIt.I;
Future<void> serviceLocator() async {
  sl.registerSingletonAsync<SharedPreferenceManager>(() async {
    final SharedPreferenceManager sharedPreferenceManager =
        SharedPreferenceManager();
    await sharedPreferenceManager.init();
    return sharedPreferenceManager;
  });

  sl.registerLazySingleton<ProductServices>(() => ProductServices());
  sl.registerFactory(() => ProductBloc(productServices: sl()));

  sl.registerLazySingleton<CartServices>(
    () => CartServices(sharedPreferenceManager: sl()),
  );
  sl.registerFactory(() => CartBloc(cartServices: sl()));
}
