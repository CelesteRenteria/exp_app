import 'dart:math';

import 'package:exp_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {

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
  _max;
  super.initState();
  
}

@override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }

double get _max => max(90-_offset*90,0.0);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: const CustomFAB(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const SliverAppBar(
            elevation: 0.0,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MonthSelector(),
                  Text("\$2,500",style: TextStyle(fontSize: 30, color: Colors.green)),
                  Text("Balace",style: TextStyle(fontSize: 19))
                ],
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate(
            [
              Stack(
                children:[
                  const BackSheet(),
                  Padding(
                    padding:  EdgeInsets.only(top:_max),
                    child: const FrontSheet()
                  )
                ]
              )
            ]
          ))
        ],
      ),
    );
  }
}