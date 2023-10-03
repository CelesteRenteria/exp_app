import 'dart:convert';

import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/models/expenses_model.dart';
import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/providers/db_expenses.dart';
import 'package:exp_app/providers/db_features.dart';
import 'package:flutter/material.dart';

class ExpensesProvider extends ChangeNotifier{
  List<FeaturesModel> data = [];
  List<ExpensesModel> eList = [];
  List<CombinedModel> cList = [];

/* --- Functions to insert --- */

  addNewFeatures(FeaturesModel newFeature)async{
    // final newFeature = FeaturesModel(
    //   category: category,
    //   color:color,
    //   icon:icon
    // );

    final id = await DBFeatures.db.addNewFeature(newFeature);
    newFeature.id = id;
    data.add(newFeature);
    notifyListeners();
  }

  addNewExpense(CombinedModel cModel)async{
    var expenses = ExpensesModel(link: cModel.link!, year: cModel.year, month: cModel.month, day: cModel.day, comment: cModel.comment, expense: cModel.amount);
    final id  = await DBExpenses.db.addExpense(expenses);
    expenses.id = id;
    eList.add(expenses);
    notifyListeners();
  }
  
/* --- Functions to read --- */

  getAllFeatures()async{
    final response = await DBFeatures.db.getAllFeatures();
    data = [...response];
    notifyListeners();
  }

  getExpensesByDate(int month, int year)async{
    final response = await DBExpenses.db.getExpensesByDate(month, year);
    eList = [...response];
    notifyListeners();
  }


/* --- Functions to update --- */

  updateFeatures(FeaturesModel features)async{
    await DBFeatures.db.updateFeatures(features);
    getAllFeatures();
    // notifyListeners();
  }

  updateExpense(CombinedModel cModel)async{
    var expenses = ExpensesModel(id: cModel.id!,link: cModel.link!, year: cModel.year, month: cModel.month, day: cModel.day, comment: cModel.comment, expense: cModel.amount);
    await DBExpenses.db.updateExpense(expenses);
    notifyListeners();
  }

  /* --- Functions to delete --- */
  deleteExpense(int id)async{
    await DBExpenses.db.deleteExpense(id);
    notifyListeners();
  }


  /* --- Getters to Combined List ---*/
  List<CombinedModel> get allItemsList{
    // ignore: no_leading_underscores_for_local_identifiers
    List<CombinedModel> _cModel = [];
    for(var x in eList){
      for(var y in data){
        if(x.link==y.id){
          _cModel.add(CombinedModel(
            category: y.category,
            color: y.color,
            icon: y.icon,
            id: x.id,
            amount: x.expense,
            comment: x.comment,
            year: x.year,
            month: x.month,
            day: x.day
          ));
        }
      }
    }
    return cList = [..._cModel];
  }


  List<CombinedModel> get groupItemsList{
    // ignore: no_leading_underscores_for_local_identifiers
    List<CombinedModel> _cModel = [];
    for(var x in eList){
      for(var y in data){
        if(x.link==y.id){
          // ignore: no_leading_underscores_for_local_identifiers
          double _amount = eList.where((e) => e.link == y.id)
          .fold(0.0, (a, b) => a+b.expense); //hacer la suma
          _cModel.add(CombinedModel(
            category: y.category,
            color: y.color,
            icon: y.icon,
          // id: x.id,
          amount: _amount,
          // comment: x.comment,
          // year: x.year,
          // month: x.month,
          // day: x.day
          ));
        }
      }
    }
    var encode = _cModel.map((e) => jsonEncode(e)); //convierte a iterable de strings
    var unique = encode.toSet(); //agrupa los elementos iguales
    var result = unique.map((e) => jsonDecode(e)); //quita las comillas
    _cModel = result.map((e) => CombinedModel.fromJson(e)).toList();

    return cList = [..._cModel];
  }

}