import 'package:exp_app/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    //final uiProvider = Provider.of<UIProvider>(context);

    final watchIndex = context.watch<UIProvider>();
    final read = context.read<UIProvider>();

    return BottomNavigationBar(
      elevation: 0.0,
      currentIndex: watchIndex.bnbIndex,
      onTap: (int i)=> read.bnbIndex = i,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_outlined), label:"Balance"),
          BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),label:"Gráficos"),
          BottomNavigationBarItem(
          icon: Icon(Icons.settings),label:"Configuración"),
          
      ]);
  }
}