import 'package:PROWORK/model/model_task.dart';
import 'package:PROWORK/service_locator.dart';
import 'package:PROWORK/viewmodel/task_viewmodel.dart';
import 'package:PROWORK/widgets/taskReqCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskRequest extends StatefulWidget {
  @override
  _TaskRequestState createState() => _TaskRequestState();
}

class _TaskRequestState extends State<TaskRequest> {
  final taskViewModel = serviceLocator.get<TaskViewModel>();

  _showModalBottomSheet(TaskViewModel model, TaskMapping taskMapping) {
    showModalBottomSheet(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext ctx, StateSetter setModalState) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child:
                    _modalBottomSheetBody(setModalState, model, taskMapping));
          });
        });
  }

  _modalBottomSheetBody(
      StateSetter setModalState, TaskViewModel model, TaskMapping taskMapping) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 150, right: 150),
            child: Container(
              height: 5,
              width: 2,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(50)),
            )),
        SizedBox(height: 15),
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      maxRadius: 20,
                      foregroundImage: NetworkImage(
                          taskMapping.employee['Profile']['profileUrl']),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(taskMapping.employee['Profile']['fname'] +
                      " " +
                      taskMapping.employee['Profile']['lname']),
                ],
              )
            ]),
        SizedBox(height: 10),
        Text(
          "User Information",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
        ),
        SizedBox(height: 5),
        ListTile(
          isThreeLine: true,
          leading: Icon(Icons.location_on),
          title: Text("From"),
          subtitle: Text(
            taskMapping.employee['Profile']['address'],
            maxLines: 2,
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 1,
          indent: MediaQuery.of(context).size.width - 300,
          endIndent: 0.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Reviews",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
            ),
            TextButton(
              child: Text(
                "See All",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: 5),
        model.isLoading
            ? Center(child: CircularProgressIndicator())
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text(
                      "Accept",
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () {
                      model.acceptTaskRequest(taskMapping).then((_) {
                        setModalState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(model.message)));
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                  TextButton(
                    child: Text(
                      "Decline",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {},
                  )
                ],
              )
      ],
    );
  }

  @override
  void initState() {
    taskViewModel.getTaskRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Requests')),
      body: Consumer<TaskViewModel>(
        builder: (context, model, child) {
          return model.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: model.taskRequests.length,
                  itemBuilder: (context, index) {
                    if (model.taskRequests.length < 1) {
                      return Center(
                        child: Text("No requests yet!"),
                      );
                    } else {
                      return TaskRequestCard(
                        imageUrl: model.taskRequests[index].employee['Profile']
                            ['profileUrl'],
                        userName: model.taskRequests[index].employee['Profile']
                                ['fname'] +
                            " " +
                            model.taskRequests[index].employee['Profile']
                                ['lname'],
                        onTap: () {
                          _showModalBottomSheet(
                              model, model.taskRequests[index]);
                        },
                      );
                    }
                  });
        },
      ),
    );
  }
}
