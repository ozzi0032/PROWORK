import 'package:PROWORK/model/model_category.dart';
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
  List<String> category;
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

  factory TaskModel.fromFirestore({DocumentSnapshot ds, Map mapData}) {
    var taskId = ds.id;
    var docData = ds.data();
    return TaskModel(
      employerId: docData['employerId'] ?? mapData['employerId'],
      employer: docData['employer'] ?? mapData['employer'],
      id: taskId, //ID from documentID
      title: docData['title'] ?? mapData['title'],
      description: docData['description'] ?? mapData['description'],
      price: double.parse(docData['price']) ?? double.parse(mapData['price']),
      status: docData['status'] ?? mapData['status'],
      createdDate: docData['createdDate'] ?? mapData['createdDate'],
      timeAllocated: docData['timeAllocated'] ?? mapData['timeAllocated'],
      category: docData['category'] ?? mapData['category'],
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

class TaskMapping {}
