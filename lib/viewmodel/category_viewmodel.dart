import 'package:PROWORK/enum/enum_viewState.dart';
import 'package:PROWORK/model/model_category.dart';
import 'package:PROWORK/services/index.dart';
import 'package:PROWORK/viewmodel/base_viewmodel.dart';

class CategoryViewModel extends BaseViewModel {
  final Services _service = Services();
  List<CategoryModel> categories;
  List<CategoryModel> _categories = [];
  List<CategoryModel> _subCategories = [];

  String message;

  Future<void> getCategories() async {
    try {
      setState(ViewState.Busy);
      categories = await _service.getCategories();

      //Adding parent Categories to the list from list of all categories
      for (var cat in categories) {
        CategoryModel item = categories.firstWhere(
            (element) => element.id == cat.parentId,
            orElse: () => null);
        if (item != null && item.parentId == "0") {
          if (!_categories.contains(item)) {
            _categories.add(item);
          }
        }
      }

      //Adding sub-Categories to the list
      for (var cat in categories) {
        CategoryModel item = _categories
            .firstWhere((element) => element.id == cat.id, orElse: () => null);
        if (item == null && cat.parentId != "0") {
          if (!_subCategories.contains(cat)) {
            _subCategories.add(cat);
          }
        }
      }
      categories = [
        ..._categories,
        ..._subCategories
      ]; //Put the parent categories at starting and sub-categories next to them to avoid computation complexity
      setState(ViewState.Idle);
    } catch (error) {
      message = "There is an issue with the app during request the data, "
              "please contact admin for fixing the issues " +
          error.toString();
      setState(ViewState.Idle);
    }
  }

  List<CategoryModel> get cat {
    getCategories();
    return _categories;
  }

  List<CategoryModel> get subCat {
    getCategories();
    return _subCategories;
  }
}
