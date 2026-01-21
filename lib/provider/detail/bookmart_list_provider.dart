import 'package:flutter/widgets.dart';
import 'package:practice_class/model/tourism.dart';

class BookmartListProvider extends ChangeNotifier {
  final List<Tourism> _bookmarkList = [];

  List<Tourism> get bookmarkList => _bookmarkList;

  void addBookmart(Tourism value) {
    _bookmarkList.add(value);
    notifyListeners();
  }

  void removeBookmart(Tourism value) {
    _bookmarkList.removeWhere((element) => element.id == element.id);
    notifyListeners();
  }

  bool checkItemBookmart(Tourism value) {
    final tourismInList = _bookmarkList.where(
      (element) => element.id == value.id,
    );

    return tourismInList.isNotEmpty;
  }
}
