import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:community_charts_flutter/src/text_element.dart'as element;
import 'package:community_charts_flutter/src/text_style.dart'as style;

import 'package:exp_app/models/expenses_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../../utils/utils.dart';

class ChartLine extends StatelessWidget {
  static String?  pointAmount;
  static String? pointDay;
  const ChartLine({super.key});

  @override
  Widget build(BuildContext context) {
    var eList = context.watch<ExpensesProvider>().eList;
    var currentMonth = context.watch<UIProvider>().selectedMonth + 1;

    List<ExpensesModel> eModel = [];
    Map<int, dynamic> mapExp;
    List<double> perDayList = [];

    mapExp = eList.fold({}, (Map<int, dynamic> map, exp) {
      if (!map.containsKey(exp.day)) {
        map[exp.day] = 0.0;
      }
      map[exp.day] += exp.expense;
      return map;
    });
    mapExp.forEach((key, value) {
      eModel.add(ExpensesModel(day: key, expense: value));
    });

    eModel.add(ExpensesModel(day: 0, expense: 0.0));
    eModel.sort(((a, b) => a.day.compareTo(b.day)));

    List<charts.Series<ExpensesModel, num>> series = [
      charts.Series<ExpensesModel, num>(
          id: 'ExpensesPerDay',
          domainFn: (v, i) => v.day,
          measureFn: (v, i) => v.expense,
          seriesColor: charts.ColorUtil.fromDartColor(Colors.green),
          data: eModel)
    ];
    var currentDay = dayIntMoth(currentMonth);
    perDayList = List.generate(currentDay + 1, (int i) {
      return eList
          .where((e) => e.day == (i))
          .map((e) => e.expense)
          .fold(0.0, (a, b) => a + b);
    });

    List<charts.Series<double, int>> series2 = [
      charts.Series<double, int>(
          id: 'ExpensesPerDay',
          domainFn: (v, i) => i!,
          measureFn: (v, i) => v,
          seriesColor: charts.ColorUtil.fromDartColor(Colors.green),
          //charts.MaterialPalette.purple.shadeDefault,
          radiusPxFn: (v, i) {
            if (v == 0) {
              return 0;
            }
            return 3;
          },
          data: perDayList)
    ];

    return SizedBox(
      child: charts.LineChart(
        series,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(
            includePoints: true, includeArea: true, areaOpacity: 0.5),
        primaryMeasureAxis: charts.NumericAxisSpec(
            renderSpec: charts.GridlineRendererSpec(
                lineStyle: charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.green[100]!)),
                labelJustification: charts.TickLabelJustification.outside,
                labelAnchor: charts.TickLabelAnchor.after),
            tickFormatterSpec:
                charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                    NumberFormat.simpleCurrency(decimalDigits: 0)),
            tickProviderSpec:
                const charts.BasicNumericTickProviderSpec(desiredTickCount: 6)),
        domainAxis: charts.NumericAxisSpec(
            tickProviderSpec: charts.StaticNumericTickProviderSpec([
          const charts.TickSpec(0, label: '0'),
          const charts.TickSpec(5, label: '5'),
          const charts.TickSpec(10, label: '10'),
          const charts.TickSpec(15, label: '15'),
          const charts.TickSpec(20, label: '20'),
          const charts.TickSpec(25, label: '25'),
          charts.TickSpec(currentDay, label: currentDay.toString()),
        ])),
        selectionModels: [
          charts.SelectionModelConfig(
            changedListener: (charts.SelectionModel model) {
              if(model.hasDatumSelection){
                pointAmount = getAmountFormat(model.selectedSeries[0].
                measureFn(model.selectedDatum[0].index)!.toDouble());
                pointDay = model.selectedSeries[0].domainFn(model.selectedDatum[0].index).toString();
              }
            },
          )
        ],
        behaviors: [
          charts.LinePointHighlighter(
              showHorizontalFollowLine:
                  charts.LinePointHighlighterFollowLineType.nearest,
              showVerticalFollowLine:
                  charts.LinePointHighlighterFollowLineType.nearest,
              symbolRenderer: SymbolRender()),
          charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag)
        ],
      ),
    );
  }
}

class SymbolRender extends charts.CircleSymbolRenderer {
  var txtStyle = style.TextStyle();
  
  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds,
      {List<int>? dashPattern,
      charts.Color? fillColor,
      charts.FillPatternType? fillPattern,
      charts.Color? strokeColor,
      double? strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        fillPattern: fillPattern,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);

    canvas.drawRect(
        Rectangle(bounds.left - 25, bounds.top - 30, bounds.width + 48,
            bounds.height + 18),
        fill: charts.ColorUtil.fromDartColor(Colors.grey[900]!),
        stroke: charts.ColorUtil.fromDartColor(Colors.white),
        strokeWidthPx: 1);
    txtStyle.color = charts.MaterialPalette.white;
    txtStyle.fontSize = 10;

    canvas.drawText(
    element.TextElement('Dia ${ChartLine.pointDay} \n${ChartLine.pointAmount}', style: txtStyle), 
    (bounds.left-20).round(), 
    (bounds.top-24).round());
  }
}
