import 'package:PROWORK/model/model_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String employerId;
  Map employer;
  String id;
  String title;
  String description;
  String status;
  String createdDate;
  String timeAllocated;
  List<CategoryModel> category;
  TaskModel(
      {this.employerId,
      this.employer,
      this.id,
      this.title,
      this.description,
      this.status,
      this.createdDate,
      this.timeAllocated,
      this.category});

  factory TaskModel.fromFirestore({DocumentSnapshot ds, Map mapData}) {
    var taskId = ds.id;
    return TaskModel(
      employerId: mapData['employerId'],
      employer: mapData['employer'],
      id: taskId, //ID from documentID
      title: mapData['title'],
      description: mapData['description'],
      status: mapData['status'],
      createdDate: mapData['createdDate'],
      timeAllocated: mapData['timeAllocated'],
      category: mapData['category'],
    );
  }

  toJSON(TaskModel obj) {
    final data = obj.toMap();
    return data;
  }

  Map<String, dynamic> toMap() => {
        'employerId': employerId,
        'employer': employer,
        'id': id,
        'title': title,
        'description': description,
        'status': status,
        'createdDate': createdDate,
        'timeAllocated': timeAllocated,
        'category': category
      };
}

class TaskMapping {}
