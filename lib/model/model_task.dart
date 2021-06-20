import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String employerId;
  Map employer;
  String id;
  String title;
  String description;
  double price;
  String status;
  String createdDate;
  String timeAllocated;
  List category;
  TaskModel(
      {this.employerId,
      this.employer,
      this.id,
      this.title,
      this.description,
      this.price,
      this.status,
      this.createdDate,
      this.timeAllocated,
      this.category});

  factory TaskModel.fromFirestore(DocumentSnapshot ds) {
    var taskId = ds.id;
    var docData = ds.data();
    return TaskModel(
      employerId: docData['employerId'],
      employer: docData['employer'],
      id: taskId, //ID from documentID
      title: docData['title'],
      description: docData['description'],
      price: double.parse(docData['price']),
      status: docData['status'],
      createdDate: docData['createdDate'],
      timeAllocated: docData['timeAllocated'],
      category: docData['category'],
    );
  }

  toJSON(TaskModel obj) {
    final data = obj.toMap();
    return data;
  }

  Map<String, dynamic> toMap() => {
        'employerId': employerId,
        'employer': employer,
        //'id': id,  -> For posting task to the firestore we don't need to add id
        'title': title,
        'description': description,
        'price': price.toString(),
        'status': status,
        'createdDate': createdDate,
        'timeAllocated': timeAllocated,
        'category': category
      };
}

class TaskMapping {
  Map employee;
  Map task;
  String taskId;
  TaskMapping({this.employee, this.task, this.taskId});

  factory TaskMapping.fromFirestore(DocumentSnapshot ds) {
    var map = ds.data();
    return TaskMapping(
        employee: map['employee'], task: map['task'], taskId: map['taskId']);
  }

  toJSON(TaskMapping obj) {
    final data = obj.toMap();
    return data;
  }

  Map<String, dynamic> toMap() =>
      {'employee': employee, 'task': task, 'taskId': taskId};
}
