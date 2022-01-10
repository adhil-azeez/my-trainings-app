import 'package:flutter/material.dart';
import 'package:my_trainings_app/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_trainings_app/utils/extensions.dart';

class HomeCarouselWidget extends StatefulWidget {
  const HomeCarouselWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeCarouselWidget> createState() => _HomeCarouselWidgetState();
}

class _HomeCarouselWidgetState extends State<HomeCarouselWidget> {
  final _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: _ThisRedBlueDecoration(),
            child: CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: 3,
              itemBuilder: (context, index, realIndex) =>
                  _ThisItemWidget(index: index),
              options: CarouselOptions(
                viewportFraction: 1.0,
                autoPlay: true,
              ),
            ),
          ),
        ),
        Positioned(
          left: 0.0,
          top: 0.0,
          bottom: 0.0,
          child: InkWell(
            onTap: () => _onTapPrevious(context),
            child: FractionallySizedBox(
              heightFactor: 0.65,
              child: Container(
                decoration: BoxDecoration(
                  color: colorBlack.withOpacity(0.50),
                  borderRadius: BorderRadius.circular(2),
                ),
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: colorWhite,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: .0,
          top: 0.0,
          bottom: 0.0,
          child: InkWell(
            onTap: () => _onTapNext(context),
            child: FractionallySizedBox(
              heightFactor: 0.65,
              child: Container(
                decoration: BoxDecoration(
                  color: colorBlack.withOpacity(0.50),
                  borderRadius: BorderRadius.circular(2),
                ),
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: colorWhite,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onTapPrevious(BuildContext context) =>
      _carouselController.previousPage();

  void _onTapNext(BuildContext context) => _carouselController.nextPage();
}

class _ThisItemWidget extends StatelessWidget {
  final int index;
  const _ThisItemWidget({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                foregroundDecoration:
                    BoxDecoration(color: colorBlack.withOpacity(0.50)),
                child: Image.asset(
                  "slider/slide_${index + 1}.png".asAssetImg(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 12.0,
              right: 12.0,
              bottom: 12.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Safe Scrum Master",
                    style: TextStyle(
                      fontSize: 16,
                      color: colorWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "West Des Moines, IA- 30 Oct - 31 Oct",
                    style: TextStyle(
                      fontSize: 14,
                      color: colorWhite,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "\$971",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: colorRed,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        " \$825",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: colorRed,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "View Details",
                        style: TextStyle(
                          color: colorWhite,
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: colorWhite,
                        size: 14,
                      ),
                    ],
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

class _ThisRedBlueDecoration extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _ThisBoxPainter();
  }
}

class _ThisBoxPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    final topHeight = configuration.size!.height * 0.65;
    canvas.drawRect(Offset.zero & Size(configuration.size!.width, topHeight),
        Paint()..color = colorRed);
    canvas.drawRect(
        Offset(0.0, topHeight) &
            Size(configuration.size!.width,
                configuration.size!.height - topHeight),
        Paint()..color = colorWhite);
    canvas.restore();
  }
}
