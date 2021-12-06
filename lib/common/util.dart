import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String untilTime(DateTime targetTime) {
  DateTime now = DateTime.now();

  int difference = now.difference(targetTime).inMinutes;

  int year = difference ~/ (365 * 24 * 60);
  difference %= (365 * 24 * 60);
  
  int month = difference ~/ (30 * 24 * 60);
  difference %= (30 * 24 * 60);
  
  int day = difference ~/ (24 * 60);
  difference %= (24 * 60);
  
  int hour = difference ~/ (60);
  difference %= (60);
  
  int minute = difference;

  String result;

  if(year > 0) { result = '$year년 전'; }
  else if(month > 0) { result = '$month개월 전'; }
  else if(day > 0) { result = '$day일 전'; }
  else if(hour > 0) { result = '$hour시간 전'; }
  else { result = '$minute분 전'; }

  return result;
}

Color colorByState(String state) {
  switch(state) {
    case 'participating': return Colors.cyan[300]!;
    case 'gather-complete': return Colors.yellow;
    case 'success': return Colors.green;
    case 'canceled': return Colors.red;
    default: return Colors.black;
  }
}

String stateNameByState(String state) {
  switch(state) {
    case 'participating': return '참여 가능';
    case 'gather-complete': return '모집 완료';
    case 'success': return '성공';
    case 'canceled': return '취소됨';
    default: return '?';
  }
}

String toCurrencyString(int v) {
  return NumberFormat('#,##0').format(v) + '원';
}