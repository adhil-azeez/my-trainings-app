import 'package:my_trainings_app/models/training_model.dart';
import 'package:my_trainings_app/providers/base_filter_list_provider.dart';

class TrianingListFilterProvider extends BaseFilterListProvider<TrainingModel> {
  List<String>? _selLocation, _selTrainer, _selTraining;

  @override
  List<TrainingModel> get filteredList {
    if (<List<String>?>[_selLocation, _selTrainer, _selTraining]
        .any((field) => field?.isNotEmpty ?? false)) {
      return super.filteredList;
    }
    return super.allList;
  }

  void setFilterItems({
    List<String>? selLocation,
    List<String>? selTrainer,
    List<String>? selTraining,
  }) {
    _selLocation = selLocation;
    _selTrainer = selTrainer;
    _selTraining = selTraining;
    notifyListeners();
  }

  @override
  bool filterFunOnItem(TrainingModel item) {
    if (_selLocation?.contains(item.location) ?? false) return true;
    if (_selTrainer?.contains(item.trainer) ?? false) return true;
    if (_selTraining?.contains(item.name) ?? false) return true;
    return false;
  }
}
