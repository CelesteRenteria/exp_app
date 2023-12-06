import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:exp_app/widgets/global_wt/percent_indicator_wt.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class FlayerMovements extends StatelessWidget {
  const FlayerMovements({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;
    double _totalExp = 0;
    double _totalEt = 0;

    _totalExp = getSumOfExP(eList);
    _totalEt = getSumOfEntries(etList);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 1,
            child: PercentCircular(
                radius: 80,
                color: Colors.green,
                arcType: ArcType.FULL,
                percent:_totalExp / _totalEt
                    
            )),
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 180.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Gastos Realizados',
                    style: TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 1.3
                    ),),
                    Text(getAmountFormat(_totalExp), 
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.3
                    ),),
                    Text('Absorbe un ${(_totalExp/_totalEt*100).toStringAsFixed(2)}% de tus ingresos',
                    style: TextStyle(letterSpacing: 1.3),)
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
