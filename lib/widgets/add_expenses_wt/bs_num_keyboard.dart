import 'package:exp_app/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../models/combined_model.dart';

class BSNumKeyboard extends StatefulWidget {
  final CombinedModel cModel;
  const BSNumKeyboard({super.key, required this.cModel});

  @override
  State<BSNumKeyboard> createState() => _BSNumKeyboardState();
}

class _BSNumKeyboardState extends State<BSNumKeyboard> {
  String import = '0.00';

@override
  void initState() {
    import = widget.cModel.amount.toStringAsFixed(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String Function(Match) mathFunc;
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc = (Match match) => '${match[1]},';
    return GestureDetector(
      onTap: () {
        _numPad();
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text("Cantidad ingresada"),
            Text(
              '\$ ${import.replaceAllMapped(reg, mathFunc)}',
              style: const TextStyle(
                  fontSize: 30.0,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  _numPad() {
    if(import=='0.00') import='';
  
  expenseChange(String amount){
    if(amount=='')amount='0.00';
    widget.cModel.amount = double.parse(amount);
  }

    // ignore: no_leading_underscores_for_local_identifiers
    _num(String text, double height) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          setState(() {
            import += text;
            widget.cModel.amount = double.parse(import);
          });
        },
        child: SizedBox(
          height: height,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 35.0),
            ),
          ),
        ),
      );
    }

    showModalBottomSheet(

        barrierColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        isDismissible: false,
        isScrollControlled: true,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SizedBox(
              height: 350.0,
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                var height = constraints.biggest.height / 5;
                return Column(
                  children: [
                    Table(
                      border: TableBorder.symmetric(
                          inside: const BorderSide(color: Colors.grey, width: 0.1)),
                      children: [
                        TableRow(children: [
                          _num('1', height),
                          _num('2', height),
                          _num('3', height),
                        ]),
                        TableRow(children: [
                          _num('4', height),
                          _num('5', height),
                          _num('6', height),
                        ]),
                        TableRow(children: [
                          _num('7', height),
                          _num('8', height),
                          _num('9', height),
                        ]),
                        TableRow(children: [
                          _num('.', height),
                          _num('0', height),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              setState(() {
                                if(import.length>0.0){
                                  import = import.substring(0,import.length-1);
                                  expenseChange(import);
                                }
                              });
                            },
                            onLongPress: (){
                              setState(() {
                                import = '';
                                expenseChange(import);
                              });
                            },
                            child: SizedBox(
                              height: height,
                              child: const Icon(Icons.backspace, size:35.0)),
                          )
                        ])
                      ],
                    ),
                  Row(children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            import = '0.00';
                          expenseChange(import);
                            Navigator.pop(context);
                          });
                        },
                        child:Constants.customButton(Colors.transparent, Colors.red, 'Cancelar'), 
                      ),
                    ),
          
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(import.isEmpty) import = '0.00';
                            expenseChange(import);
                            Navigator.pop(context);
                            
                            
                          });
                        },
                        child:Constants.customButton(Colors.green, Colors.transparent, 'Aceptar')
                      ),
                    )
                    
                  ],)
                  
                  ],
                );
              }),
            ),
          );
        });
  }
}
