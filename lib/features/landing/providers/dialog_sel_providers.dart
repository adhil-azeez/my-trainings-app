import 'package:flutter/material.dart';

abstract class BaseFilterSelProvider<T> extends ChangeNotifier {
  final _list = <T>[];

  List<T> get list => _list;

  void addTo(T val) {
    _list.add(val);
    notifyListeners();
  }

  void removeFrom(T val) {
    _list.remove(val);
    notifyListeners();
  }

  void clearAll() {
    _list.clear();
    notifyListeners();
  }

  bool contains(T val) => _list.contains(val);

  void toggle(T val) {
    if (contains(val)) {
      removeFrom(val);
    } else {
      addTo(val);
    }
  }
}

class FilterLocationSelProvider extends BaseFilterSelProvider<String> {}

class FilterTrainerSelProvider extends BaseFilterSelProvider<String> {}

class FilterTrainingNamesSelProvider extends BaseFilterSelProvider<String> {}
