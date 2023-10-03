import 'package:exp_app/utils/page_animation_routes.dart';
import 'package:flutter/material.dart';

import '../../pages/pages.dart';
import '../../utils/constants.dart';

class BackSheet extends StatelessWidget {
  const BackSheet({super.key});

  @override
  Widget build(BuildContext context) {
    headers(String name, String amount, Color color) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13.0, bottom: 5.0),
            child: Text(
              name,
              style: const TextStyle(
                  fontSize: 18,
                  letterSpacing: 1.5,
                  ),
            ),
          ),
          Text(
            amount,
            style:  TextStyle(
                fontSize: 20.0,
                letterSpacing: 1.5,
                color: color
                ),
          )
        ],
      );
    }

    return Container(
      height: 250.0,
      decoration: Constants.sheetBoxDecoration(Theme.of(context).primaryColorDark),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          headers('Ingresos', '\$1520',Colors.green),
          const VerticalDivider(
            thickness: 2.0,
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, PageAnimationRoutes(widget: const ExpensesDetails(), ejeX: 0.5, ejeY: -0.5));
            },
            child: headers('Gastos', '\$1500',Colors.red))
        ],
      ),
    );
  }
}
