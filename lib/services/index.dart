import 'package:PROWORK/model/model_category.dart';
import 'package:PROWORK/model/model_task.dart';
import 'package:PROWORK/services/helper/firebase.dart';

abstract class BaseServices {
  Future<List<CategoryModel>> getCategories();
  Future<void> addTask(TaskModel taskModel);
}

class Services implements BaseServices {
  BaseServices baseServices = FirebaseService();

  static final Services _instance = Services._internal();

  factory Services() => _instance;

  Services._internal();

  @override
  Future<List<CategoryModel>> getCategories() async {
    return baseServices.getCategories();
  }

  @override
  Future<void> addTask(TaskModel taskModel) async {
    baseServices.addTask(taskModel);
  }
}
