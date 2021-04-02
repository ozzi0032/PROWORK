import 'package:PROWORK/screens/buyer/addTask.dart';
import 'package:PROWORK/style/appColors.dart';
import 'package:PROWORK/widgets/taskCard.dart';
import 'package:flutter/material.dart';

class BuyerHomeFragment extends StatefulWidget {
  @override
  _BuyerHomeFragmentState createState() => _BuyerHomeFragmentState();
}

class _BuyerHomeFragmentState extends State<BuyerHomeFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.blueColorGoogle,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddTask()));
          },
          label: Row(
            children: [
              Icon(Icons.add),
              Text("Add Task"),
            ],
          )),
      body: ListView.builder(
          itemCount: 3, itemBuilder: (context, index) => TaskCard()),
    );
  }
}
