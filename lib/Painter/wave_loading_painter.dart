import 'package:flutter/material.dart';

class WaveLoadingPainter extends CustomPainter {
  //默认颜色值
  static const Color defaultColor = Colors.lightBlue;

  //画笔对象
  final _paint = Paint();

  //波浪路径
  final Path _circlePath = Path();

  //要显示的文本
  final String text;

  //字体大小
  final double fontSize;

  final Color backgroundColor;

  final Color foregroundColor;

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
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
