import 'package:flutter/material.dart';
import 'package:my_trainings_app/dummy_datas.dart';
import 'package:my_trainings_app/features/landing/dialogs/filter_pop_dialog.dart';
import 'package:my_trainings_app/features/landing/providers/dialog_sel_providers.dart';
import 'package:my_trainings_app/features/landing/providers/training_list_filter_provide.dart';
import 'package:my_trainings_app/features/landing/widgets/home_carousel_widget.dart';
import 'package:my_trainings_app/models/training_model.dart';
import 'package:my_trainings_app/utils/colors.dart';
import 'package:my_trainings_app/widgets/app_dashed_line_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => FilterLocationSelProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FilterTrainerSelProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FilterTrainingNamesSelProvider(),
          ),
          ChangeNotifierProxyProvider3<
              FilterLocationSelProvider,
              FilterTrainerSelProvider,
              FilterTrainingNamesSelProvider,
              TrianingListFilterProvider>(
            create: (_) =>
                TrianingListFilterProvider()..initList(dummyTrainingModelList),
            update: (context, locationProvider, trainerProvider, nameProvider,
                    previous) =>
                previous!
                  ..setFilterItems(
                    selLocation: locationProvider.list,
                    selTrainer: trainerProvider.list,
                    selTraining: nameProvider.list,
                  ),
          ),
        ],
        builder: (context, _) {
          return Scaffold(
            backgroundColor: colorF2,
            body: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: _ThisSliverPersistentDelegate(
                      minExtent: 110,
                      maxExtent: 140,
                      buildChild: (shrinkOffset) =>
                          const _ThisTopHeadingWidget()),
                  pinned: true,
                ),
                SliverPersistentHeader(
                  delegate: _ThisSliverPersistentDelegate(
                    buildChild: (shrinkOffset) => const HomeCarouselWidget(),
                    minExtent: 50,
                    maxExtent: 150,
                  ),
                  floating: false,
                  pinned: true,
                ),
                SliverPersistentHeader(
                  delegate: _ThisSliverPersistentDelegate(
                    buildChild: (shrinkOffset) =>
                        const _ThisFilterHedingWidget(),
                    minExtent: 50,
                    maxExtent: 80,
                  ),
                  floating: false,
                  pinned: true,
                ),
                Consumer<TrianingListFilterProvider>(
                  builder: (context, provider, child) {
                    print("########## ${provider.filteredList.length}");
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _ThisListItemWidget(
                          model: dummyTrainingModelList[index],
                        ),
                        childCount: provider.filteredList.length,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}

class _ThisFilterHedingWidget extends StatelessWidget {
  const _ThisFilterHedingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorWhite,
      padding: const EdgeInsets.only(left: 24),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          const Spacer(flex: 2),
          InkWell(
            onTap: () => _onTapFilter(context),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: colorC4),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.format_align_left_sharp,
                    color: colorC4,
                    size: 12,
                  ),
                  Text(
                    "  Filter",
                    style: TextStyle(
                      fontSize: 10,
                      color: colorC4,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void _onTapFilter(BuildContext context) => showFilterPopDialog(
        context: context,
        locationSelProvider: context.read<FilterLocationSelProvider>(),
        namesSelProvider: context.read<FilterTrainingNamesSelProvider>(),
        trainerSelProvider: context.read<FilterTrainerSelProvider>(),
      );
}

class _ThisListItemWidget extends StatelessWidget {
  final TrainingModel model;
  const _ThisListItemWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 6,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Oct 11 - 13,\n2019",
                  style: TextStyle(
                    fontSize: 14,
                    color: colorBlack,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "08:30 am - 12:30 pm",
                  style: TextStyle(
                    fontSize: 10,
                    color: colorBlack,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Text(
                  "Convention Hall,\n${model.location}",
                  style: TextStyle(
                    fontSize: 10,
                    color: colorBlack,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            AppDashedLineWidget(
              margin: const EdgeInsets.only(left: 12, right: 16),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Filling Fast!",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "${model.name} (4.6)",
                    style: TextStyle(
                      fontSize: 14,
                      color: colorBlack,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://i.pravatar.cc/300",
                        ),
                        radius: 24,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Keynote Speaker",
                              style: TextStyle(
                                color: colorBlack,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              model.trainer,
                              style: TextStyle(
                                color: colorBlack,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 36,
                      child: ElevatedButton(
                        child: const Text("Enroll Now"),
                        onPressed: () {},
                      ),
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
}

class _ThisSliverPersistentDelegate extends SliverPersistentHeaderDelegate {
  final double _maxExtent;
  final double _minExtent;
  final Widget Function(double shrinkOffset) buildChild;

  _ThisSliverPersistentDelegate({
    required double maxExtent,
    required double minExtent,
    required this.buildChild,
  })  : _minExtent = minExtent,
        _maxExtent = maxExtent,
        super();
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return buildChild(shrinkOffset);
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _ThisTopHeadingWidget extends StatelessWidget {
  const _ThisTopHeadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorRed,
        border: Border.all(color: colorRed),
      ),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8).add(
        const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 2),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Trainings",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    fontFamily: "TimesNewRoman",
                    color: colorWhite,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu),
                color: Colors.white,
              ),
            ],
          ),
          const Spacer(flex: 4),
          Text(
            "Highlights",
            style: TextStyle(
              color: colorWhite,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(flex: 10),
        ],
      ),
    );
  }
}
