import 'package:flutter/material.dart';
import 'package:my_trainings_app/features/landing/widgets/home_carousel_widget.dart';
import 'package:my_trainings_app/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _ThisSliverPersistentHeaderDelegate(),
            pinned: true,
          ),
          SliverPersistentHeader(
            delegate: _SliverCarouselDelegate(),
            floating: false,
            pinned: false,
          ),
        ],
      ),
    );
  }
}

class _ThisSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const _ThisTopHeadingWidget();
  }

  @override
  double get maxExtent => 170;

  @override
  double get minExtent => 170;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
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
      padding:
          EdgeInsets.only(top: MediaQuery.of(context).padding.top + 24).add(
        const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
          const SizedBox(height: 24),
          Text(
            "Highlights",
            style: TextStyle(
              color: colorWhite,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverCarouselDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return HomeCarouselWidget();
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
