// ignore: depend_on_referenced_packages
import 'package:exp_app/models/entries_model.dart';
import 'package:exp_app/models/expenses_model.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
export 'package:exp_app/utils/math_operations.dart';

getAmountFormat(double amount){
  return NumberFormat.simpleCurrency().format(amount);
}

getSumOfExP(List<ExpensesModel> eList){
  double _eList;

  _eList = eList.map((e) => e.expense).fold(0.0, (a, b) => a + b);
  return _eList;
}

getSumOfEntries(List<EntriesModel> etList){
  double _etList;

  _etList = etList.map((e) => e.entries).fold(0.0, (a, b) => a + b);
  return _etList;
}

getBalance(List<ExpensesModel>eList, List<EntriesModel>etList){
double balance;
balance = getSumOfEntries(etList) - getSumOfExP(eList);
return getAmountFormat(balance);
}