import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        //height: 150,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Task Title",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Text("Task Description",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Text("Create Date",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Text("First Name",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Text("Last Name",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Text("Email",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Text("Phone Number",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Text("Price",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Text("Status",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Text("Time Allocated",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
