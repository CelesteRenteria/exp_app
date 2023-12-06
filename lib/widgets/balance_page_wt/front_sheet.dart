import 'package:exp_app/widgets/balance_page_wt/flayer_balance.dart';
import 'package:exp_app/widgets/balance_page_wt/flayer_frecuency.dart';
import 'package:exp_app/widgets/balance_page_wt/flayer_movements.dart';
import 'package:exp_app/widgets/balance_page_wt/flayer_skin.dart';
import 'package:exp_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/expenses_provider.dart';
import '../../utils/constants.dart';

class FrontSheet extends StatelessWidget {
  const FrontSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    bool hasData =false;

  if(eList.isNotEmpty){
    hasData = true;
  }

    return Container(
      
      decoration: Constants.sheetBoxDecoration(
          Theme.of(context).scaffoldBackgroundColor),
      child: 
      (hasData)?
      ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children:  [
            const FlayerSkin(title: 'Categoría de Gastos', myWidget: FlayerCategories()),
            const FlayerSkin(title: 'Frecuencia de Gastos', myWidget: FlayerFrecuency()),
            const FlayerSkin(title: 'Movimientos', myWidget: FlayerMovements()),
            const FlayerSkin(title: 'Balance General', myWidget: FlayerBalance()),
            Container(
              padding: const EdgeInsets.all(35.0),
              child: Image.asset('assets/notes.png'),
            )
          ]):
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(50),
                child: Image.asset('assets/empty.png'),
              ),
              const Text('No tienes gastos este mes!', maxLines: 1,style: TextStyle(fontSize:15, letterSpacing: 1.3))
            ])
          ,
    );
  }
}
