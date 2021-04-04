import 'package:PROWORK/model/model_category.dart';

abstract class BaseServices {
  Future<List<CategoryModel>> getCategories();
}

class Services implements BaseServices {
  BaseServices baseServices;

  static final Services _instance = Services._internal();

  factory Services() => _instance;

  Services._internal();
  @override
  Future<List<CategoryModel>> getCategories() {
    return baseServices.getCategories();
  }
}
