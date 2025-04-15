import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuangHuy extends StatefulWidget {
  const QuangHuy({super.key});

  @override
  _QuangHuyState createState() => _QuangHuyState();
}

class _QuangHuyState extends State<QuangHuy> {
  List<Map<String, dynamic>> purchaseHistory = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('purchase_history') ?? [];

    setState(() {
      purchaseHistory = history
          .map((item) => json.decode(item) as Map<String, dynamic>)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(title: const Text(''),automaticallyImplyLeading: false,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Mọi thắc mắc liên hệ ADMIN Quang Huy\n Zalo, SDT 0981866764\n Nhận nv pic poc kingkong 180tr, săn đệ tử td,nm 80tr, xd 40tr, fide 123 50tr",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),),
          )
        ],
      )

      );
  }
}
