import 'package:flutter/cupertino.dart';

class CountProvider with ChangeNotifier{
  int _count =0;
  int get cout => _count;

  void tanggia() async{
    _count++;
    notifyListeners();
  }
}