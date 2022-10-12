import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class WaveLoadingPainter extends CustomPainter {
  //默认颜色值
  static const Color defaultColor = Colors.lightBlue;

  //画笔对象
  final _paint = Paint();

  //圆形路径
  final Path _circlePath = Path();

  //波浪路径
  final Path _wavePath = Path();

  //要显示的文本
  final String text;

  //字体大小
  final double? fontSize;

  final Color? backgroundColor;

  final Color? foregroundColor;

  final Color? waveColor;

  WaveLoadingPainter(
    this.text,
    this.fontSize,
    this.backgroundColor,
    this.foregroundColor,
    this.waveColor,
  ) {
    _paint
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..strokeWidth = 3
      ..color = waveColor ?? defaultColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double side = min(size.width, size.height);

    double radius = side / 2.0;

    //文字
    _drawText(canvas: canvas, side: side, color: backgroundColor);

    _circlePath.reset();
    //构建圆形路径
    _circlePath.addArc(Rect.fromLTWH(0, 0, side, side), 0, 2 * pi);

    double waveWidth = side * 0.8;

    double waveHeight = side / 6;

    _wavePath.reset();
    //构建波浪线路径
    _wavePath.moveTo(-waveWidth, radius);

    for (double i = -waveHeight; i < side; i += waveWidth) {
      _wavePath.relativeQuadraticBezierTo(
          waveWidth / 4, -waveHeight, waveWidth / 2, 0);
      _wavePath.relativeQuadraticBezierTo(
          waveWidth / 4, waveHeight, waveWidth / 2, 0);
    }

    canvas.drawPath(_wavePath, _paint);
  }

  void _drawText({required Canvas canvas, required double side, Color? color}) {
    ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.center,
      fontWeight: FontWeight.normal,
      fontSize: fontSize ?? 0,
    ));

    pb.pushStyle(ui.TextStyle(color: color ?? defaultColor));
    pb.addText(text);
    ui.ParagraphConstraints pc = ui.ParagraphConstraints(width: fontSize ?? 0);

    //等价于ui.Paragraph paragraph = pb.build();paragraph.layout(pc);
    ui.Paragraph paragraph = pb.build()..layout(pc);

    canvas.drawParagraph(
      paragraph,
      Offset((side - paragraph.width) / 2.0, (side - paragraph.height) / 2.0),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
