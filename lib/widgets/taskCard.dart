import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String taskTitle;
  final String taskStatus;
  final String createdDate;
  TaskCard(
      {this.imageUrl,
      this.userName,
      this.taskTitle,
      this.taskStatus,
      this.createdDate});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      maxRadius: 25,
                      foregroundImage: NetworkImage(imageUrl),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(taskTitle),
              Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  createdDate,
                  style: TextStyle(fontSize: 20),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 25,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.lime,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(child: Text(taskStatus)),
                  )
                ],
              )
            ],
          )),
    );
  }
}
