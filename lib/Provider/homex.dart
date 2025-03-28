
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getx.dart'; // Import đúng file

class Homex extends StatelessWidget {
  final CountGet c = Get.put(CountGet());

  Homex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GetX Example')),
      body: Center(
        child: Obx(() => Text('Count: ${c.a}',
            style: TextStyle(fontSize: 30))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => c.increment(),
        child: Icon(Icons.add),
      ),
    );
  }
}
