import 'package:PROWORK/style/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProviderHomeFragment extends StatefulWidget {
  @override
  _ProviderHomeFragmentState createState() => _ProviderHomeFragmentState();
}

class _ProviderHomeFragmentState extends State<ProviderHomeFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.blueColorGoogle,
          onPressed: () {
            /*Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddTask()));*/
          },
          label: Row(
            children: [
              Icon(Icons.add),
              Text("Apply for Task"),
            ],
          )),
      body: ListView.builder(
          itemCount: 1, itemBuilder: (context, index) => Text('Home')),
    );
  }
}
