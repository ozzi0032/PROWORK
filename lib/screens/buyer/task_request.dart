import 'package:flutter/material.dart';

class TaskRequest extends StatefulWidget {
  @override
  _TaskRequestState createState() => _TaskRequestState();
}

class _TaskRequestState extends State<TaskRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Requests')),
    );
  }
}
