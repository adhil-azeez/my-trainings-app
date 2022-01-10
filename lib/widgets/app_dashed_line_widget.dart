import 'package:flutter/material.dart';
import 'package:my_trainings_app/utils/colors.dart';

class AppDashedLineWidget extends Container {
  final double lineGapSize;
  final double lineSize;
  AppDashedLineWidget({
    this.lineGapSize = 3,
    this.lineSize = 5,
    Key? key,
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? margin,
  }) : super(
          key: key,
          alignment: alignment,
          padding: padding,
          width: width,
          height: height,
          constraints: constraints,
          margin: margin,
        );

  @override
  Decoration? get decoration => _ThisDecoration(
        lineSize: lineSize,
        lineGapSize: lineGapSize,
      );
}

class _ThisDecoration extends Decoration {
  final double lineSize, lineGapSize;

  const _ThisDecoration({required this.lineSize, required this.lineGapSize})
      : super();

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _ThisBoxPainter(
      lineSize: lineSize,
      lineGapSize: lineGapSize,
    );
  }
}

class _ThisBoxPainter extends BoxPainter {
  final double lineSize, lineGapSize;

  _ThisBoxPainter({required this.lineSize, required this.lineGapSize})
      : super();
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    final Size size = configuration.size ?? Size.zero;

    double lineFrom = 0.0;
    while (lineFrom < size.height) {
      double lineTo = lineFrom + lineSize;
      if (lineTo > size.height) {
        lineTo = size.height;
      }
      _drawLine(canvas, lineFrom, lineTo, size.width * 0.5);
      lineFrom += lineSize + lineGapSize;
    }

    canvas.restore();
  }

  void _drawLine(Canvas canvas, double from, double to, double center) =>
      canvas.drawLine(
        Offset(center, from),
        Offset(center, to),
        Paint()
          ..style = PaintingStyle.fill
          ..color = colorC4.withOpacity(0.5)
          ..strokeWidth = 2,
      );
}
