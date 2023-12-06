import 'package:exp_app/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntriesDetails extends StatefulWidget {
  const EntriesDetails({super.key});

  @override
  State<EntriesDetails> createState() => _EntriesDetailsState();
}

class _EntriesDetailsState extends State<EntriesDetails> {
  @override
  Widget build(BuildContext context) {
    final etList = context.watch<ExpensesProvider>().etList;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Desglose de Ingresos"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildBuilderDelegate((context, index) {
            var item = etList[index];
            return ListTile(
              title: Text(item.entries.toString()),
            );
          },
          childCount: etList.length
          
          ))
        ],
      ),
    );
  }
}
