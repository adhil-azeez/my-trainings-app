import 'package:flutter/material.dart';
import 'package:my_trainings_app/dummy_datas.dart';
import 'package:my_trainings_app/features/landing/providers/dialog_sel_providers.dart';
import 'package:my_trainings_app/features/landing/providers/search_provider.dart';
import 'package:my_trainings_app/providers/base_filter_list_provider.dart';
import 'package:provider/provider.dart';

abstract class _ThisBaseFilterContentWidget<SP extends BaseStringSearchProvider,
    FP extends BaseFilterSelProvider> extends StatelessWidget {
  const _ThisBaseFilterContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(8, 8, 24, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            onChanged: (value) => context.read<SP>().searchText = value,
            decoration: const InputDecoration(
              hintText: "Search",
              border: OutlineInputBorder(),
              isDense: true,
              hintStyle: TextStyle(fontSize: 12),
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: Consumer<SP>(builder: (context, provider, _) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => _ThisCheckBoxItemWidget<FP>(
                  location: provider.filteredList[index],
                ),
                itemCount: provider.filteredList.length,
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ThisCheckBoxItemWidget<FP extends BaseFilterSelProvider>
    extends StatelessWidget {
  final String location;

  const _ThisCheckBoxItemWidget({
    required this.location,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectionProvider = context.watch<FP>();
    final bool isSelected = selectionProvider.contains(location);

    return InkWell(
      onTap: () => selectionProvider.toggle(location),
      child: IgnorePointer(
        ignoring: true,
        child: Row(
          children: [
            SizedBox.fromSize(
              size: const Size.fromRadius(16),
              child: FittedBox(
                child: Checkbox(
                  value: isSelected,
                  onChanged: (_) => selectionProvider.toggle(location),
                ),
              ),
            ),
            Expanded(
              child: Text(
                location,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationFilterContentWidget extends _ThisBaseFilterContentWidget<
    FilterSearchProvider, FilterLocationSelProvider> {
  const LocationFilterContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FilterSearchProvider>(
          create: (context) => FilterSearchProvider()..initList(dummyLocations),
        ),
      ],
      builder: (context, _) => super.build(context),
    );
  }
}

class TrainersFilterContentWidget extends _ThisBaseFilterContentWidget<
    FilterSearchProvider, FilterTrainerSelProvider> {
  const TrainersFilterContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FilterSearchProvider>(
          create: (context) =>
              FilterSearchProvider()..initList(dummyTrainerNames),
        ),
      ],
      builder: (context, _) => super.build(context),
    );
  }
}

class TrainingNameFilterContentWidget extends _ThisBaseFilterContentWidget<
    FilterSearchProvider, FilterTrainingNamesSelProvider> {
  const TrainingNameFilterContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FilterSearchProvider>(
          create: (context) =>
              FilterSearchProvider()..initList(dummyTrainingNames),
        ),
      ],
      builder: (context, _) => super.build(context),
    );
  }
}

class _ThisFilterContentWidget extends StatefulWidget {
  const _ThisFilterContentWidget({
    Key? key,
    required this.e,
  }) : super(key: key);

  final EnumFilterOptions e;

  @override
  State<_ThisFilterContentWidget> createState() =>
      __ThisFilterContentWidgetState();
}

class __ThisFilterContentWidgetState extends State<_ThisFilterContentWidget> {
  final double _itemSize = 48;
  bool _isInitialised = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _isInitialised = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? title;

    switch (widget.e) {
      case EnumFilterOptions.sortBy:
        title = "Sort By";
        break;
      case EnumFilterOptions.location:
        title = "Location";
        break;
      case EnumFilterOptions.name:
        title = "Training Name";
        break;
      case EnumFilterOptions.trainer:
        title = "Trainer";
        break;
    }

    return Consumer<_ThisFilterOptionSelProvider>(
      builder: (context, provider, child) {
        FontWeight fontWeight = FontWeight.w400;
        Color bgColor = Colors.transparent;

        if (provider.selOption == widget.e) {
          if (_isInitialised) {
            Future.microtask(() => Scrollable.ensureVisible(context,
                duration: const Duration(milliseconds: 350),
                curve: Curves.decelerate,
                alignment: 1.0,
                alignmentPolicy: ScrollPositionAlignmentPolicy.explicit));
          }

          fontWeight = FontWeight.w700;
          bgColor = Colors.white;
        }

        return SizedBox(
          height: _itemSize,
          child: InkWell(
            onTap: () => provider.selOption = widget.e,
            child: Container(
              color: bgColor,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 450),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 100,
                  ),
                  child: Text(
                    title ?? "",
                    style: TextStyle(
                      fontWeight: fontWeight,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ThisFilterOptionSelProvider extends ChangeNotifier {
  EnumFilterOptions _enumABC = EnumFilterOptions.location;

  EnumFilterOptions get selOption => _enumABC;

  set selOption(EnumFilterOptions val) {
    _enumABC = val;
    notifyListeners();
  }
}

enum EnumFilterOptions {
  sortBy,
  location,
  name,
  trainer,
}

class FilterDialogWidget extends StatefulWidget {
  final FilterLocationSelProvider locationSelProvider;
  final FilterTrainerSelProvider trainerSelProvider;
  final FilterTrainingNamesSelProvider namesSelProvider;
  const FilterDialogWidget({
    Key? key,
    required this.locationSelProvider,
    required this.trainerSelProvider,
    required this.namesSelProvider,
  }) : super(key: key);

  @override
  _FilterDialogWidgetState createState() => _FilterDialogWidgetState();
}

class _FilterDialogWidgetState extends State<FilterDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: widget.locationSelProvider,
        ),
        ChangeNotifierProvider.value(
          value: widget.trainerSelProvider,
        ),
        ChangeNotifierProvider.value(
          value: widget.namesSelProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => _ThisFilterOptionSelProvider(),
        ),
      ],
      builder: (context, child) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Sort and Filters",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _onTapClose(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _ThisFilterTabWidget(),
                  Expanded(
                    child: Consumer<_ThisFilterOptionSelProvider>(
                      builder: (context, provider, _) {
                        Widget child = Container(
                          color: Colors.grey.shade100,
                          alignment: Alignment.center,
                          child: Text(
                            "Coming soon...",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade400),
                          ),
                        );

                        switch (provider.selOption) {
                          case EnumFilterOptions.sortBy:
                            break;
                          case EnumFilterOptions.location:
                            child = const LocationFilterContentWidget();
                            break;
                          case EnumFilterOptions.name:
                            child = const TrainingNameFilterContentWidget();

                            break;
                          case EnumFilterOptions.trainer:
                            child = const TrainersFilterContentWidget();
                            break;
                        }
                        return AnimatedSwitcher(
                          reverseDuration: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 1000),
                          switchInCurve: Curves.easeInOutSine,
                          switchOutCurve: Curves.decelerate,
                          transitionBuilder: (child, animation) =>
                              FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: animation.drive<Offset>(Tween<Offset>(
                                begin: const Offset(1.0, 0.0),
                                end: const Offset(0.0, 0.0),
                              )),
                              child: child,
                            ),
                          ),
                          child: child,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapClose(BuildContext context) => Navigator.of(context).pop();
}

class _ThisFilterTabWidget extends StatelessWidget {
  final double _itemSize = 48;
  const _ThisFilterTabWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<_ThisFilterOptionSelProvider>(
              builder: (context, provider, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.decelerate,
                  width: 4,
                  height: _itemSize,
                  color: Theme.of(context).primaryColor,
                  margin: EdgeInsets.only(
                      top:
                          EnumFilterOptions.values.indexOf(provider.selOption) *
                              _itemSize),
                );
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: EnumFilterOptions.values
                  .map((e) => _ThisFilterContentWidget(e: e))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
