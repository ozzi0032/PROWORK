import 'package:PROWORK/model/model_task.dart';
import 'package:PROWORK/service_locator.dart';
import 'package:PROWORK/style/appColors.dart';
import 'package:PROWORK/viewmodel/task_viewmodel.dart';
import 'package:PROWORK/widgets/appPrimaryButton.dart';
import 'package:flutter/material.dart';

class TaskDetail extends StatefulWidget {
  final TaskModel taskModel;
  TaskDetail({@required this.taskModel});
  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  final taskViewModel = serviceLocator.get<TaskViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Task Details')),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Text(
              "Title",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            Text(
              widget.taskModel.title,
              style: TextStyle(fontSize: 20, color: AppColors.grey800),
            ),
            SizedBox(height: 5),
            Text(
              "Description",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            Text(
              widget.taskModel.description,
              style: TextStyle(fontSize: 20, color: AppColors.grey800),
            ),
            SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.width / 2.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      ClipOval(
                          child: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        maxRadius: 18,
                        foregroundImage: NetworkImage(
                            widget.taskModel.employer['Profile']['profileUrl']),
                      )),
                      SizedBox(width: 10),
                      Text(
                        widget.taskModel.employer['Profile']['fname'] +
                            " " +
                            widget.taskModel.employer['Profile']['lname'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Time Allocated",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.taskModel.timeAllocated,
                        style:
                            TextStyle(fontSize: 18, color: AppColors.grey800),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.taskModel.price.toString() + " " + "PKR",
                        style:
                            TextStyle(fontSize: 18, color: AppColors.grey800),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.taskModel.status,
                        style:
                            TextStyle(fontSize: 18, color: AppColors.grey800),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Created Date",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.taskModel.createdDate,
                        style:
                            TextStyle(fontSize: 18, color: AppColors.grey800),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            taskViewModel.isLoading
                ? CircularProgressIndicator()
                : InkWell(
                    onTap: () {
                      taskViewModel.applyForTask(widget.taskModel).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(taskViewModel.message)));
                      });
                    },
                    child: AppButton(title: 'Apply')),
          ],
        ));
  }
}
