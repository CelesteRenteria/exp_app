import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentLinear extends StatelessWidget {
  final double percent;
  final Color color;
  const PercentLinear({super.key,
  required this.percent,
  required this.color
  });

  @override
  Widget build(BuildContext context) {

    var _percent = percent;
    if(_percent>1){
      _percent = 1;
    }

    return LinearPercentIndicator(
      animation: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      lineHeight: 16.0,
      percent: _percent,
      barRadius: const Radius.circular(10.0),
      //progressColor: color,
      linearGradient:  LinearGradient(
        colors: [
          Colors.grey,
          color
        ]),
      center: Text(
        style: const TextStyle(fontSize: 12),
        '${(_percent*100).toStringAsFixed(2)}%'),
    );
  }
}


class PercentCircular extends StatelessWidget {
  final double percent;
  final double radius;
  final Color color;
  final ArcType arcType;
  const PercentCircular({super.key, 
  required this.radius,
  required this.color,
  required this.arcType,
  required this.percent});

  @override
  Widget build(BuildContext context) {
    var _percent = percent;
    if(_percent>1){
      _percent = 1;
    }
    return CircularPercentIndicator(
      radius: radius,
      animation: true,
      animationDuration: 1000,
      percent: _percent,
      progressColor: color,
      // linearGradient: LinearGradient(colors: [
      //   Colors.grey,
      //   color
      // ]),
      arcType: arcType,
      backgroundWidth: 0.0,
      lineWidth: 12.0,
      circularStrokeCap: CircularStrokeCap.round,
      center: Text(
        style: const TextStyle(fontSize: 20),
        '${(_percent*100).toStringAsFixed(0)}%'),
    );
  }
}