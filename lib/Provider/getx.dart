import 'package:get/get.dart';

class CountGet extends GetxController{
  var a = 0.obs;
  void increment() {
    a++; // Tăng giá trị count
  }
}