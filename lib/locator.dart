import 'package:get_it/get_it.dart';

import 'viewmodel/login_viewmodel.dart';

GetIt locator = GetIt.asNewInstance();
void setupLocator() {
  locator.registerLazySingleton(() => LoginViewModel());
}
