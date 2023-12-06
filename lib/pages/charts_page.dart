import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/widgets/chat_page_wt/chart_line.dart';
import 'package:exp_app/widgets/chat_page_wt/chart_pie.dart';
import 'package:exp_app/widgets/chat_page_wt/chart_selector.dart';
import 'package:exp_app/widgets/chat_page_wt/chart_switch.dart';
import 'package:exp_app/widgets/chat_page_wt/per_category_list.dart';
import 'package:exp_app/widgets/chat_page_wt/per_day_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentChart = context.watch<UIProvider>().selectedChart;
    bool _isPerDay = false;

    if(currentChart=='Gráfico Lineal'
    || currentChart =='Gráfico de Dispersión'){
      _isPerDay = true;
    }


    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        title: Text(currentChart),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: CustomScrollView(
        slivers:[
          const SliverAppBar(
            expandedHeight: 350.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,                  children: [
                    ChartSelector(),
                    Expanded(
                      child: ChartSwitch()
                      )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              //padding: const EdgeInsets.only(top: 10.0),
              height: 30,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                decoration: Constants.sheetBoxDecoration(Theme.of(context).primaryColorDark),
              ),
            ),
          ),
         (_isPerDay)?
         const PerDayList():
         const PerCategoryList()
        ]
      ),
    );
  }
}