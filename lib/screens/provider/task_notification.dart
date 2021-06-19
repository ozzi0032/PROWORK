import 'package:PROWORK/viewmodel/task_viewmodel.dart';
import 'package:PROWORK/widgets/taskCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskNotification extends StatefulWidget {
  @override
  _TaskNotificationState createState() => _TaskNotificationState();
}

class _TaskNotificationState extends State<TaskNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Notification"),
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, model, child) {
          return ListView.builder(
              itemCount: model.notifiedTasks.length,
              itemBuilder: (context, index) {
                if (model.notifiedTasks.length < 1) {
                  return Center(child: Text("Empty"));
                } else {
                  return TaskCard(
                      userName: model.notifiedTasks[index].employer['Profile']
                              ['fname'] +
                          ' ' +
                          model.notifiedTasks[index].employer['Profile']
                              ['lname'],
                      imageUrl: model.notifiedTasks[index].employer['Profile']
                          ['profileUrl'],
                      taskTitle: model.notifiedTasks[index].title,
                      taskStatus: model.notifiedTasks[index].status,
                      createdDate: model.notifiedTasks[index].createdDate);
                }
              });
        },
      ),
    );
  }
}
