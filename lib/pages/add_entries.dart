import 'package:exp_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../models/combined_model.dart';
import '../utils/constants.dart';

class AddEntries extends StatelessWidget {
  const AddEntries({super.key});

  @override
  Widget build(BuildContext context) {
    CombinedModel cModel = CombinedModel();
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Ingreso"),
      ),
      body:Column(
        children:  [
          BSNumKeyboard(cModel: cModel,),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: Constants.sheetBoxDecoration(Theme.of(context).primaryColorDark),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 DatePicker(cModel: cModel),
                CommentBox(cModel: cModel,),
                  Expanded(child: Center(child: SaveButtonEntries(cModel: cModel,)))
                ],
              ),
            ),
          )
        ]
      )
    );
  }
}