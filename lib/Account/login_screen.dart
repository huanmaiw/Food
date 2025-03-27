import 'package:flutter/material.dart';
import 'package:food/Account/register_screen.dart';
import 'package:food/Home/main_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Đăng Nhập", style: TextStyle(color: Colors.black,fontSize: 25,
                fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            TextField(decoration: InputDecoration(
              hintText: "Tài khoản hoặc Email",
              border: OutlineInputBorder(),
            ),),
            SizedBox(height: 20,),
            TextField(decoration: InputDecoration(
              hintText: "Mật khẩu",
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                }, child: Text("Quên mật khẩu ?", style: TextStyle(color: Colors.blue),)),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.white),
                  onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                  },
                  child: Text("Đăng Nhập")),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.grey),
                  onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>RegisterScreen()));
              }, child: Text("Tạo tài khoản mới")),
            ),
            SizedBox(height: 20,),
            RichText(text: TextSpan(
              text: "Điều khoản dịch vụ",
              style: TextStyle(color: Colors.blue),
              children: [
              TextSpan(
              text: " và ",
              style: TextStyle(color: Colors.grey),
            ),
                TextSpan(
                  text: "Chính sách bảo mật",
                  style: TextStyle(color: Colors.blue
                )
                ),
            ]
            )
            )
          ],
        ),
      ),
    );
  }
}
