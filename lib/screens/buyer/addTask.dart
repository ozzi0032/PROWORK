import 'package:PROWORK/model/model_category.dart';
import 'package:PROWORK/style/appColors.dart';
import 'package:PROWORK/viewmodel/category_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String _skill;
  List<CategoryModel> categoriesList = [];
  CategoryModel _selectedCategory = CategoryModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text("Add Task")),
          body: ListView(
            padding: const EdgeInsets.all(5.0),
            children: [
              Text(
                "What Service Are You Looking For?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Describe the service you are looking for - please be as detailed as possible:",
                style: TextStyle(fontSize: 18, color: AppColors.grey800),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                height: MediaQuery.of(context).size.height / 3.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0)),
                child: TextField(
                  //autofocus: true,
                  cursorHeight: 25.0,
                  cursorColor: AppColors.blueColorGoogle,
                  style: TextStyle(fontSize: 18),
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: 15,
                  enabled: true,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Type here..'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Choose a category:",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 50.0,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0)),
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Categories")
                        .where("ParentId", isEqualTo: "0")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      snapshot.data.docs.forEach((category) {
                        categoriesList
                            .add(CategoryModel.fromFirestore(category));
                      });
                      return DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: false,
                          elevation: 7,
                          items: categoriesList.map((category) {
                            return DropdownMenuItem(
                              value: category.name,
                              child: Text("${category.name}"),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(
                              () {
                                _selectedCategory.name = value;
                              },
                            );
                          },
                          value: _selectedCategory.name,
                          hint: Text("Select category"),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 50.0,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0)),
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Categories")
                        .where("ParentId", isEqualTo: _selectedCategory.id)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: false,
                          elevation: 7,
                          items: snapshot.data.docs.map((value) {
                            return DropdownMenuItem(
                              value: value.get("Name"),
                              child: Text("${value.get("Name")}"),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(
                              () {
                                _skill = value;
                              },
                            );
                          },
                          value: _skill,
                          hint: Text("Select sub-category"),
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
