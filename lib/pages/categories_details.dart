import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:exp_app/utils/utils.dart';
import 'package:exp_app/widgets/global_wt/percent_indicator_wt.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class CategoriesDetails extends StatefulWidget {
  const CategoriesDetails({super.key});

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  @override
  Widget build(BuildContext context) {
    final cModel = ModalRoute.of(context)!.settings.arguments as CombinedModel;
    var cList = context.watch<ExpensesProvider>().allItemsList;
    var eList = context.watch<ExpensesProvider>().eList;
    var etList = context.watch<ExpensesProvider>().etList;

var totalEt = getAmountFormat(
  getSumOfEntries(etList)
);

var totalEx = getAmountFormat(
  getSumOfExP(eList)
);

    cList.where((element) => element.category == cModel.category).toList();

    return Scaffold(
      
      backgroundColor: Theme.of(context).primaryColorDark,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            
            expandedHeight: 180.0,
            title: Text(cModel.category),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0,),
                  child: Text(
                      
                      getAmountFormat(cModel.amount),style: const TextStyle(fontSize: 18),),
                ),
              )
            ],
            flexibleSpace:  FlexibleSpaceBar(
                background: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      PercentCircular(
                          arcType: ArcType.HALF,
                          radius: 70,
                          color: Colors.green,
                          percent: cModel.amount/getSumOfEntries(etList)),
                      Text(
                        textAlign: TextAlign.center,
                        'Absorbe de tus \nIngresos: $totalEt'),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      PercentCircular(
                          arcType: ArcType.HALF,
                          radius: 70,
                          color: Colors.red,
                          percent: cModel.amount/getSumOfExP(eList)),
                      Text(
                        textAlign: TextAlign.center,
                        'Representa de tus\n Gastos: $totalEx'),
                    ],
                  ),
                ],
              ),
            )),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 15.0),
              height: 40.0,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                decoration: Constants.sheetBoxDecoration(
                    Theme.of(context).primaryColorDark),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            var item = cList[index];

            return ListTile(
              leading: Stack
              (alignment: AlignmentDirectional.center,
                children: [
                  const Icon(Icons.calendar_today,size: 40.0,),
                  Positioned(
                    top: 16,
                    child: Text(item.day.toString()))
              ]),
              title: PercentLinear(
                //TODO:RAROOOOOOOOOOOO
                percent: (item.amount*1)/cModel.amount,
               // percent: ((item.amount / cModel.amount)<1)?item.amount / cModel.amount:1,
               // percent: item.amount/(double.parse(totalEx.toString().split('\$').last)),
                color: item.color.toColor(),
              ),
              trailing: Text(
                
                getAmountFormat(
                item.amount
              ),style: const TextStyle(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold
                ),),
            );
          }, childCount: cList.length))
        ],
      ),
    );
  }
}
