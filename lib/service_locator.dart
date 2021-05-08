import 'package:PROWORK/viewmodel/category_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;
void setupServiceLocator() {
  serviceLocator.registerFactory<CategoryViewModel>(() => CategoryViewModel());
}
