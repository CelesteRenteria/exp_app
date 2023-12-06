import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:exp_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ExpensesDetails extends StatefulWidget {
  const ExpensesDetails({super.key});

  @override
  State<ExpensesDetails> createState() => _ExpensesDetailsState();
}

class _ExpensesDetailsState extends State<ExpensesDetails> {
  final _scrollController = ScrollController();
  double _offset = 0;
  List<CombinedModel> cList = [];

  void _listener() {
    setState(() {
      _offset = _scrollController.offset / 100;
      if (_offset > 0.8) _offset = 0.8;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_listener);
    cList = context.read<ExpensesProvider>().allItemsList;
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
    final dataDay = ModalRoute.of(context)!.settings.arguments as int?;
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();
    cList = context.watch<ExpensesProvider>().allItemsList;
    //final cList = exProvider.allItemsList;
    double totalExp = 0.0;
    if(dataDay!=null){
      cList=cList.where((e) => e.day==dataDay).toList();
      
    }
    
    totalExp = cList.map((e) => e.amount).fold(0.0, (a, b) => a + b);
    cList.sort((a,b)=>b.day.compareTo(a.day));
    
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
                alignment: Alignment(_offset, 1),
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
              decoration: Constants.sheetBoxDecoration(
                  Theme.of(context).primaryColorDark),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, i) {
          var item = cList[i];
          return Slidable(
            key: ValueKey(item),
            startActionPane:
                ActionPane(motion: const BehindMotion(), children: [
              SlidableAction(
                  autoClose: true,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: "Borrar",
                  onPressed: (context) {
                    setState(() {
                      cList.removeAt(i);
                    });
                    exProvider.deleteExpense(item.id!);
                    uiProvider.bnbIndex = 0;
                    Fluttertoast.showToast(
                        msg: 'Gasto Eliminado', backgroundColor: Colors.red);
                  }),
              SlidableAction(
                  autoClose: true,
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: "Editar",
                  onPressed: (context) {
                    Navigator.pushNamed(context, 'addExpense', arguments: item);
                  })
            ]),
            child: ListTile(
              leading: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 40,
                  ),
                  Positioned(top: 16, child: Text(item.day.toString()))
                  // Icon(item.icon.toIcon(), color: item.color.toColor(), size: 35.0),
                ],
              ),
              title: Row(
                children: [
                  Text(item.category),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Icon(item.icon.toIcon(), color: item.color.toColor())
                ],
              ),
              subtitle: Text(item.comment),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    getAmountFormat(item.amount),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${(100 * item.amount / totalExp).toStringAsFixed(2)}%',
                    style: const TextStyle(fontSize: 11),
                  )
                ],
              ),
            ),
          );
        }, childCount: cList.length))
      ],
    ));
  }
}
