import 'package:flutter/cupertino.dart';

class MainProvider extends ChangeNotifier {
  String _title = TitleType.ALL_TODO;

  String get title => _title;

  void getTitle(String type) {
    switch (type) {
      case TitleType.ALL_TODO:
        this._title = TitleType.ALL_TODO;
        break;
      case TitleType.COMPLETED_TODO:
        this._title = TitleType.COMPLETED_TODO;
        break;
      case TitleType.UNCOMPLETED_TODO:
        this._title = TitleType.UNCOMPLETED_TODO;
        break;
    }
    notifyListeners();
  }
}

class TitleType {
  static const String ALL_TODO = 'All Todos';
  static const String COMPLETED_TODO = 'Completed Todos';
  static const String UNCOMPLETED_TODO = 'Uncompleted Todos';
}
