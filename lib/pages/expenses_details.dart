import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:exp_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesDetails extends StatefulWidget {
  const ExpensesDetails({super.key});

  @override
  State<ExpensesDetails> createState() => _ExpensesDetailsState();
}

class _ExpensesDetailsState extends State<ExpensesDetails> {
  final _scrollController = ScrollController();
double _offset = 0;

void _listener(){
setState(() {
  _offset = _scrollController.offset/100;
});
}

@override
void initState() {
  _scrollController.addListener(_listener);
  super.initState();
  
}

@override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final exProvider = context.watch<ExpensesProvider>();
    final cList = exProvider.allItemsList;
    double totalExp = 0.0;

    totalExp = cList.map((e) => e.amount).fold(0.0, (a, b) => a+b);

    if(_offset>0.8) _offset = 0.8;
  //   final expenses = exProvider.eList;
  //   final features = exProvider.data;
  //   List<CombinedModel> cList = [];

  // for (var e in expenses) {
  //   for (var f in features) {
  //     if(e.link==f.id){
  //       cList.add(CombinedModel(
  //         category: f.category,
  //         color: f.color,
  //         icon: f.icon,
  //         amount: e.expense,
  //         comment: e.comment
  //       ));
  //     }
  //   }
  // }

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
          expandedHeight: 125.0,
          title: const Text('Desglose de gastos'),
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Align(
              alignment: Alignment(_offset,1),
              child: Text(getAmountFormat(totalExp))),
            centerTitle: true,
            background: const Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Text('Total'),
            ),
          ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 15.0),
              height: 30,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                decoration: Constants.sheetBoxDecoration(Theme.of(context).primaryColorDark),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i){
            var item = cList[i];
            return ListTile(
              leading: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  const Icon(Icons.calendar_today, size: 40,),
                  Positioned(
                    top: 16,
                    child: Text(item.day.toString()))
                  // Icon(item.icon.toIcon(), color: item.color.toColor(), size: 35.0),
                ],
              ),
              title:Row(
                children: [
                  Text(item.category),
                  const SizedBox(width: 8.0,),
                  Icon(item.icon.toIcon(), color: item.color.toColor())
                ],
              ),
              subtitle: Text(item.comment),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(getAmountFormat(item.amount), style: const TextStyle(fontWeight: FontWeight.bold),),
                  Text('${(100*item.amount/totalExp).toStringAsFixed(2)}%', style: const TextStyle(fontSize: 11),)
                ],
              ),
            );
          },
          childCount: cList.length))
        ],
      )
    );
  }
}