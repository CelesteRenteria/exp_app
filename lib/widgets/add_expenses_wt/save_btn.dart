import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class SaveButton extends StatelessWidget {
  final CombinedModel cModel;
  const SaveButton({super.key, required this.cModel});

  @override
  Widget build(BuildContext context) {
    final expProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();
    return GestureDetector(
      onTap:(){
        if(cModel.amount!=0.0 && cModel.link!=null){
          expProvider.addNewExpense(cModel);
          Fluttertoast.showToast(msg: 'Gasto agregado!', backgroundColor: Colors.green);
          uiProvider.bnbIndex = 0;
          Navigator.pop(context);
          }
        else if(cModel.amount == 0.0){
          Fluttertoast.showToast(msg: 'No olvides agregar un monto!', backgroundColor: Colors.red);
        }
        else {
          Fluttertoast.showToast(msg: 'No olvides agregar una categoría!', backgroundColor: Colors.red);
        }


        
      },
        child: 
        SizedBox
        (
          height: 80.0,
          width:120,
          child: Constants.customButton(
          Colors.green,
          Colors.white,
          "Guardar"
        ),)
        
      );
    
  }
}