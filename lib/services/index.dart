import 'package:PROWORK/model/model_category.dart';
import 'package:PROWORK/model/model_task.dart';
import 'package:PROWORK/model/model_user.dart';
import 'package:PROWORK/services/helper/firebase.dart';

abstract class BaseServices {
  Future<List<CategoryModel>> getCategories();
  Future<void> addTask(TaskModel taskModel);
  Future<List<TaskModel>> getTask(UserModel userModel);
  Future<List<TaskModel>> getTaskNotification(SkillsMapping skillsMapping);
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
    return baseServices.addTask(taskModel);
  }

  @override
  Future<List<TaskModel>> getTask(UserModel userModel) async {
    return baseServices.getTask(userModel);
  }

  @override
  Future<List<TaskModel>> getTaskNotification(SkillsMapping skillsMapping) async {
    return baseServices.getTaskNotification(skillsMapping);
  }
}
