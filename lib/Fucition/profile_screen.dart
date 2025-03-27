
import 'package:flutter/material.dart';
import 'package:food/Account/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 100,
              child: Image.asset("images/bdct.jpg"),
            ),
            SizedBox(height: 15,),
            Text("Xin chao (ten truy cap)"),
            SizedBox(height: 15,),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                }, child: Text("Đăng Xuất")),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                }, child: Text("Đổi thông tin cá nhân")),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                }, child: Text("No one")),

          ],
        ),
      ),
    );
  }
}
