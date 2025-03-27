import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final TextEditingController _phoneController = TextEditingController();
  void sendOTP() async{
    String phone = _phoneController.text.trim();
    if(phone.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui long nhap sdt")),
      );
      return ;
    }
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+84$phone", // +84 là mã Việt Nam
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Xác thực thất bại: ${e.message}")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pushNamed(context, "/otp", arguments: verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dang ki bang SDT"),),
      body: Padding(padding: const EdgeInsets.all(16.0),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: "Nhap SDT",
            prefixText: "+84",
            border: OutlineInputBorder(),
          ),),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: sendOTP, child: Text("Send OTP")),
        ],
      ),),
    );
  }
}
