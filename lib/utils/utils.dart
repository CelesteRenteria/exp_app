import 'package:flutter/material.dart';

import 'icon_list.dart';

export 'package:exp_app/utils/utils.dart';


int dayIntMoth(int month){
  var now = DateTime.now();
  var lastDay = month<12
  ? DateTime(now.year,month+1,0)
  : DateTime(now.year+1,1,0);
  return lastDay.day;
}

extension ColorsApp on String{
  toColor(){
    String hexColor = replaceAll('#', '');
    if(hexColor.length==6){
      hexColor = 'FF$hexColor';
    }
    if(hexColor.length ==8){
      return Color(int.parse('0x$hexColor'));
    }
  }
}

extension IconExtension on String{
  toIcon(){
   return IconList().iconMap[this];
  }
}