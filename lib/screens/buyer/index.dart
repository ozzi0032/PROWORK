import 'package:PROWORK/screens/buyer/addTask.dart';
import 'package:PROWORK/service_locator.dart';
import 'package:PROWORK/style/appColors.dart';
import 'package:PROWORK/viewmodel/task_viewmodel.dart';
import 'package:PROWORK/widgets/taskCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyerHomeFragment extends StatefulWidget {
  @override
  _BuyerHomeFragmentState createState() => _BuyerHomeFragmentState();
}

class _BuyerHomeFragmentState extends State<BuyerHomeFragment> {
  final taskViewModel = serviceLocator.get<TaskViewModel>();

  @override
  void initState() {
    taskViewModel.getMyTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColors.blueColorGoogle,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddTask()));
            },
            label: Row(
              children: [
                Icon(Icons.add),
                Text("Add Task"),
              ],
            )),
        body: Consumer<TaskViewModel>(builder: (context, model, child) {
          return model.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: model.myTasks.length,
                  itemBuilder: (context, index) {
                    if (model.myTasks.length > 0) {
                      return TaskCard(
                          userName: model.myTasks[index].employer['Profile']
                                  ['fname'] +
                              ' ' +
                              model.myTasks[index].employer['Profile']['lname'],
                          imageUrl: model.myTasks[index].employer['Profile']
                              ['profileUrl'],
                          taskTitle: model.myTasks[index].title,
                          taskStatus: model.myTasks[index].status,
                          createdDate: model.myTasks[index].createdDate);
                    } else {
                      return Center(
                        child: Text('Empty'),
                      );
                    }
                  });
        }));
  }
}
