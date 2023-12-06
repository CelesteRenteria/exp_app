import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/widgets/chat_page_wt/char_scatterplot.dart';
import 'package:exp_app/widgets/chat_page_wt/chart_line.dart';
import 'package:exp_app/widgets/chat_page_wt/chart_pie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartSwitch extends StatelessWidget {
  const ChartSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final currentChart = context.watch<UIProvider>().selectedChart;
    
    switch(currentChart){
      case 'Gráfico Lineal': return const ChartLine();
      case 'Gráfico Pie': return const ChartPie();
      case 'Gráfico de Dispersión': return const ChartScatterPlot();
      default: return const ChartLine();
    }
  }
}