import 'package:flutter/material.dart';
import 'package:stick_loading_view/Painter/wave_loading_painter.dart';

class WaveLoadingWidget extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? waveColor;

  const WaveLoadingWidget({
    Key? key,
    required this.text,
    required this.fontSize,
    this.backgroundColor,
    this.foregroundColor,
    this.waveColor,
  })  : assert(text.length >= 1),
        assert(fontSize > 0),
        super(key: key);

  @override
  _WaveLoadingWidgetState createState() => _WaveLoadingWidgetState(
        text: text,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        fontSize: fontSize,
        waveColor: waveColor,
      );
}

class _WaveLoadingWidgetState extends State<WaveLoadingWidget>
    with SingleTickerProviderStateMixin {
  final String text;

  final double fontSize;

  final Color? backgroundColor;

  final Color? foregroundColor;

  final Color? waveColor;

  late AnimationController controller;

  late Animation<double> animation;

  _WaveLoadingWidgetState(
      {required this.text,
      required this.fontSize,
      this.backgroundColor,
      this.foregroundColor,
      this.waveColor});

  @override
  void initState() {
    // TODO: implement initState
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.dismissed:
          print('dismissed');
          break;
        case AnimationStatus.forward:
          print('forward');
          break;
        case AnimationStatus.reverse:
          print('reverse');
          break;
        case AnimationStatus.completed:
          print('completed');
          break;
      }
    });
    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WaveLoadingPainter(text, fontSize, backgroundColor,
          foregroundColor, waveColor, animation.value),
    );
  }
}
