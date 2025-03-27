import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food/Account/login_screen.dart';

class SlapsScreen extends StatefulWidget {
  const SlapsScreen({super.key});

  @override
  State<SlapsScreen> createState() => _SlapsScreenState();
}

class _SlapsScreenState extends State<SlapsScreen> {
  @override
  void initState() {
    super.initState();
Timer(Duration(seconds: 3),(){
  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Image.asset("images/slap.webp",fit: BoxFit.contain,height: 200,width: 200,),
            SizedBox(height: 20,),
            Text("Welcome to Food Order by QuangHuy",style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold, fontSize: 20),),
          ],
        ),
      ),
    );
  }
}
