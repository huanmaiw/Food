import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../Account/auth_service.dart';
import '../../../Account/forget_password.dart';
import '../../../Account/sign_up_screen.dart';
import '../../../drawers.dart';
import '../Feature/View/policy.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool isPasswordHidden= true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    'images/ct.jpg',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Tên người dùng hoặc Số điện thoại',border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _passwordController,
                  decoration:  InputDecoration(labelText: 'Mật khẩu',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                      icon: Icon(
                          isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility
                      ),
                    ),
                  ),
                  obscureText: isPasswordHidden,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Đăng nhập'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context)=>ForgotPasswordScreen()));
                      },
                      child: const Text('Quên mật khẩu '),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context)=>RegisterScreen()));
                  },
                  child: const Text('Chưa có tài khoản? Đăng kí ngay'),
                ),
                SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Điều Khoản Dịch Vụ ",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context)=>
                                          Chinhsachbaomat()));
                            },
                          style: TextStyle(color: Colors.blue,
                              fontWeight: FontWeight.bold)
                      ),
                      TextSpan(
                        text: "và",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextSpan(
                          text: " Chính Sách Bảo Mật",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Chinhsachbaomat()));
                            },
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)
                      ),
                    ],

                  ),
                ),
                SizedBox(height: 18,),
                // Padding(
                //   padding: const EdgeInsets.only(left: 300.0),
                //   child: FloatingActionButton(
                //     onPressed: (){
                //       Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginAdmin()));
                //     },
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(35.0),),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(35.0),
                //       child: Image.asset('images/logo.jpg',
                //         width: 80,
                //         height: 80,
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      User? user = await AuthService().loginWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
      setState(() {
        _isLoading = false;
      });
      if (user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Drawers()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tài khoản hoặc mật khẩu không chính xác')),
        );
      }
    }
  }
  // void _login() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //
  //     String validEmail = "quanghuyvip10";
  //     String validPassword = "123456";
  //
  //     if (_emailController.text == validEmail && _passwordController.text == validPassword) {
  //       setState(() {
  //         _isLoading = true;
  //       });
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => Drawers()),
  //       );
  //     } else {
  //
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Tài khoản hoặc mật khẩu không chính xác')),
  //       );
  //     }
  //   }
  // }

}