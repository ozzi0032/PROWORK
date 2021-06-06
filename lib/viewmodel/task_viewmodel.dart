import 'package:PROWORK/model/model_task.dart';
import 'package:PROWORK/service_locator.dart';
import 'package:PROWORK/services/index.dart';
import 'package:PROWORK/viewmodel/user_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import '../utills/date_time_utils.dart';

class TaskViewModel extends ChangeNotifier {
  final Services _service = Services();
  //To access the registered objects call get<Type>() on your GetIt instance
  final userViewModel = serviceLocator.get<UserViewModel>();

  bool isLoading = false;
  String message = 'message';

  Future<void> addTask(TaskModel taskModel) async {
    taskModel.employerId = userViewModel.user.userId;
    taskModel.employer = userViewModel.user.toMap(); //User object as a map
    taskModel.status =
        'unassigned'; //Initially the task added will be unassigned

    //Format the current time for task creation time
    taskModel.createdDate = DateTime.now().toString();
    // DateTimeUtils.format(
    //     int.parse(DateTime.now().toString()),
    //     DateTimeFormatConstants.eEEEdMMMMyFormat);

    try {
      isLoading = true;
      notifyListeners();
      await _service.addTask(taskModel);
      message = "Task successfully added";
      isLoading = false;
      notifyListeners();
    } catch (e) {
      message = "There is an issue with the app during request the data, "
              "please contact admin for fixing the issues " +
          e.toString();
      isLoading = false;
      notifyListeners();
    }
  }
}
