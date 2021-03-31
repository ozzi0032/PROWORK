import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
          height: 150,
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
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "User Name",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("This is task title"),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mar 17,2021",
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    height: 25,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.lime,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(child: Text("Status")),
                  )
                ],
              )
            ],
          )),
    );
  }
}
