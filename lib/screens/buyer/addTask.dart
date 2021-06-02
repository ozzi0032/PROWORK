import 'package:PROWORK/model/model_category.dart';
import 'package:PROWORK/style/appColors.dart';
import 'package:PROWORK/utills/appConstraints.dart';
import 'package:PROWORK/viewmodel/category_viewmodel.dart';
import 'package:PROWORK/widgets/appInputField.dart';
import 'package:PROWORK/widgets/appPrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  bool _subCatVisiblity = false;
  CategoryModel _catSelectedItem;
  CategoryModel _subCatSelectedItem;
  List<DropdownMenuItem<CategoryModel>> _catDropdownMenuItems;
  List<DropdownMenuItem<CategoryModel>> _subCatDropdownMenuItems;

  @override
  void initState() {
    renderDropdownButtons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Task")),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Text(
            "Title",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          AppCustomInputField(
            labelText: AppConstants.taskTitleLabel,
            height: MediaQuery.of(context).size.height / 15.0,
            maxLines: 2,
            hasValidation: true,
          ),
          SizedBox(height: 10),
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
          AppCustomInputField(
            labelText: AppConstants
                .taskDesLabel, // This label is for validation purpose
            hintText: 'Type here...',
            height: MediaQuery.of(context).size.height / 3.0,
            maxLines: 15,
            hasValidation: true,
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
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: Text("Select a category"),
                  value: _catSelectedItem,
                  items: _catDropdownMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _catSelectedItem = value;
                      _subCatDropdownMenuItems =
                          buildSubCatDropdownMenuItems(value);
                      _subCatVisiblity = true;
                    });
                  },
                ),
              )),
          SizedBox(
            height: 5,
          ),
          Visibility(
              visible: _subCatVisiblity,
              child: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text("Select sub-category"),
                      value: _subCatSelectedItem,
                      items: _subCatDropdownMenuItems,
                      onChanged: (value) {
                        setState(() {
                          _subCatSelectedItem = value;
                        });
                      },
                    ),
                  ))),
          SizedBox(
            height: 10,
          ),
          Text(
            "Once you add your task, when would you like your task completed?",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Days',
                style: TextStyle(fontSize: 24),
              ),
              Container(
                //padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(icon: Icon(Icons.add), onPressed: () {}),
                    Text(
                      'Count',
                    ),
                    IconButton(icon: Icon(Icons.remove), onPressed: () {}),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "What is your budget for this service?",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          AppCustomInputField(
            labelText: AppConstants
                .taskBudgetLabel, //This label is for validation purpose
            // hintText: 'Type here...',
            height: MediaQuery.of(context).size.height / 15.0,
            hasValidation: true,
            prefixIcon: Icon(Icons.money),
          ),
          SizedBox(
            height: 10,
          ),
          AppButton(
            title: 'Add Task',
          )
        ],
      ),
    );
  }

  renderDropdownButtons() {
    _catDropdownMenuItems = buildCatDropdownMenuItems();
  }

  List<DropdownMenuItem<CategoryModel>> buildCatDropdownMenuItems() {
    final categories =
        Provider.of<CategoryViewModel>(context, listen: false).categories;
    List<DropdownMenuItem<CategoryModel>> cats = [];
    if (categories != null) {
      var list =
          categories.where((element) => element.parentId == "0").toList();
      for (var index in list) {
        cats.add(DropdownMenuItem(value: index, child: Text(index.name)));
      }

      setState(() {
        _catSelectedItem = list[0];
        _subCatDropdownMenuItems = buildSubCatDropdownMenuItems(list[0]);
      });

      return cats;
    }
    return [
      DropdownMenuItem(
          value: _catSelectedItem, child: Text(_catSelectedItem.name))
    ];
  }

  List<DropdownMenuItem<CategoryModel>> buildSubCatDropdownMenuItems(
      CategoryModel category) {
    final categories =
        Provider.of<CategoryViewModel>(context, listen: false).categories;
    List<DropdownMenuItem<CategoryModel>> subCats = [];
    if (categories != null) {
      var list = categories
          .where((element) => element.parentId == category.id)
          .toList();
      for (var index in list) {
        subCats.add(DropdownMenuItem(value: index, child: Text(index.name)));
      }

      setState(() {
        _subCatSelectedItem = list[0];
      });

      return subCats;
    }
    return [
      DropdownMenuItem(
          value: _subCatSelectedItem, child: Text(_subCatSelectedItem.name))
    ];
  }
}
