import 'package:PROWORK/model/model_category.dart';
import 'package:PROWORK/services/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService implements BaseServices {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<CategoryModel> categories = [];

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      if (categories.isNotEmpty) {
        return categories;
      }
      List<CategoryModel> list = [];
      var snapshot = await _firebaseFirestore.collection('Categories').get();
      snapshot.docs.forEach((document) {
        list.add(CategoryModel.fromFirestore(document));
      });
      categories = list;
      return list;
    } catch (e) {
      return [];
    }
  }
}
