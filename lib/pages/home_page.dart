import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expenses_provider.dart';
import '../providers/ui_provider.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: _HomePage(),
    );
  }
}


class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
  final uiProvider = Provider.of<UIProvider>(context);
  //final exProvider = Provider.of<ExpensesProvider>(context,listen:false);
  final exProvider = context.read<ExpensesProvider>();
  final DateTime date = DateTime.now();
  final  currentIndex = uiProvider.bnbIndex;
  final currentMonth =  uiProvider.selectedMonth+1;
    switch(currentIndex){
      case 0:
      exProvider.getEntriesByDate(currentMonth, date.year);
      exProvider.getExpensesByDate(currentMonth, date.year);
      exProvider.getAllFeatures();
      return const BalancePage();
      case 1:
      return const ChartsPage();
      default: return const BalancePage();
    }
  }
}