import 'package:flutter/material.dart';

abstract class BaseFilterListProvider<T> extends ChangeNotifier {
  final _list = <T>[];

  List<T> get allList => _list;

  void initList(List<T> val) {
    _list.clear();
    _list.addAll(val);
    notifyListeners();
  }

  bool filterFunOnItem(T item);

  List<T> get filteredList =>
      _list.where((item) => filterFunOnItem(item)).toList();
}

abstract class BaseSearchProvider<T> extends BaseFilterListProvider<T> {
  String? _searchText;

  String? get searchText => _searchText;

  set searchText(String? val) {
    _searchText = val;
    notifyListeners();
  }

  @override
  List<T> get filteredList {
    final text = _searchText?.trim();
    if (text?.isEmpty ?? true) return super.allList;
    return super.filteredList;
  }
}

abstract class BaseStringSearchProvider extends BaseSearchProvider<String> {
  @override
  bool filterFunOnItem(String item) =>
      item.toLowerCase().contains(_searchText!.trim().toLowerCase());
}
