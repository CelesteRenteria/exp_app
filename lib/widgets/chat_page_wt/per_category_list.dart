import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:exp_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerCategoryList extends StatelessWidget {
  const PerCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final gList = context.watch<ExpensesProvider>().groupItemsList;

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index){
        var item = gList[index];
        return ListTile(
          onTap: (){
            Navigator.pushNamed(context, 
            'cat_details',
            arguments: item);
          },
          title: Text(item.category),
          leading: Icon(item.icon.toIcon(),
          color: item.color.toColor(),
          size: 35.0,),
          trailing: Text(
            getAmountFormat(item.amount),
          ),
        );
      },
      childCount: gList.length),
    );
  }
}