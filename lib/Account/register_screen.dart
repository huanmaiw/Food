import 'package:flutter/material.dart';
import 'package:food/Account/login_screen.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Đăng Kí", style: TextStyle(color: Colors.black,fontSize: 25,
                fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            TextField(decoration: InputDecoration(
              hintText: "Tên truy cập",
              border: OutlineInputBorder(),
            ),),
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
            TextField(decoration: InputDecoration(
              hintText: "Nhập lại mật khẩu",
              border: OutlineInputBorder(),
            ),
              obscureText: true,
            ),
            SizedBox(height: 15,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.white),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                  },
                  child: Text("Đăng Kí")),
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
