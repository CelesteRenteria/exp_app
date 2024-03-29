import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/ui_provider.dart';

class MonthSelector extends StatelessWidget {
  const MonthSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = context.read<UIProvider>();
    int currentPage = context.watch<UIProvider>().selectedMonth;
    PageController controller;

    controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4
    );
    return SizedBox(
      height: 50.0,
      child: PageView(
        onPageChanged: (int i)=>uiProvider.selectedMonth=i,
        controller: controller,
        children: [
          _pageItems('Enero', 0, currentPage),        
          _pageItems('Febrero', 1, currentPage),        
          _pageItems('Marzo', 2, currentPage),        
          _pageItems('Abril', 3, currentPage),        
          _pageItems('Mayo', 4, currentPage),        
          _pageItems('Junio', 5, currentPage),        
          _pageItems('Julio', 6, currentPage),        
          _pageItems('Agosto', 7, currentPage),        
          _pageItems('Septiembre', 8, currentPage),        
          _pageItems('Octubre', 9, currentPage),        
          _pageItems('Noviembre', 10, currentPage),        
          _pageItems('Diciembre', 11, currentPage),    
    
        ],
      ),
    );
  }

  _pageItems(String name, int position, int currentPage){
    // ignore: no_leading_underscores_for_local_identifiers
    var _alignment = Alignment.center;

    const selected = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

    final unSelected = TextStyle(fontSize: 18, color: Colors.grey[700]);

    if(position == currentPage){
      _alignment = Alignment.center;
    }else if(position>currentPage){
      _alignment = Alignment.centerRight/2;
    }else{
      _alignment = Alignment.centerLeft/2;
    }

    return Align(
      alignment: _alignment,
      child: Text(
        name,
        style: position==currentPage?selected:unSelected,
      ),
    );

  }
}