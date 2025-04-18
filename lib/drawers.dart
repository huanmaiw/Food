import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food/Main/User/Feature/View/policy.dart';
import 'package:food/Main/User/Feature/Controller/setting_account.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Main/User/Acc/login_user.dart';
import 'Main/User/Feature/Controller/favorite_user.dart';
import 'Main/User/Feature/Details/balence.dart';
import 'Main/User/Feature/View/contact_admin.dart';
import 'Main/User/Feature/View/home_screen_user.dart';
import 'Main/User/Feature/View/order_tracking.dart';

class Drawers extends StatefulWidget {
  const Drawers({super.key});
  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {

  String userId = "61560768990877";

  File? _avatarImage;
  final ImagePicker _picker = ImagePicker();

  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    Favorite(),
    OrderTracking(),
    SettingAccount(),
    QuangHuy(),
    Chinhsachbaomat(),
  ];
  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _avatarImage = File(image.path);
      });
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      print('Lỗi đăng xuất: $e');
    }
  }

  void _editUserId() {
    TextEditingController controller = TextEditingController(text: userId);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Chỉnh sửa ID"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Nhập ID mới"),
          ),
          actions: [
            TextButton(
              child: const Text("Hủy"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Lưu"),
              onPressed: () {
                setState(() {
                  userId = controller.text; // Cập nhật ID
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận đăng xuất'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Không'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Có'),
              onPressed: () {
                Navigator.of(context).pop();
                _signOut(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quang Huy', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 5,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children:[
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: _avatarImage != null
                            ? FileImage(_avatarImage!)
                            : const AssetImage('images/ct.jpg') as ImageProvider,
                      ),
                      Positioned(
                        bottom: -15,
                        right: -5,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Wrap(
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.photo),
                                        title: const Text('Chọn từ thư viện'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          _pickImage(ImageSource.gallery);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.camera),
                                        title: const Text('Chụp ảnh'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          _pickImage(ImageSource.camera);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ] ,
                  ),
                  const SizedBox(height:20),
                  Consumer<BalanceProvider>(
                    builder: (context, balanceProvider, child) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: _editUserId, // Khi ấn vào ID, hộp thoại chỉnh sửa sẽ mở
                            child: Text(
                              'ID: $userId',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          SizedBox(height: 5,),
                          Text(
                            'Số tiền: ${NumberFormat.currency(locale: 'vi_VN', symbol: 'VND', decimalDigits: 0).format(balanceProvider.balance)}',
                            style: const TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(Icons.home, 'Trang chủ', 0),
                  _buildDrawerItem(Icons.shopping_cart_outlined, 'Giỏ hàng', 1),
                  _buildDrawerItem(Icons.card_giftcard, 'Theo dõi đơn hàng', 2),
                  _buildDrawerItem(Icons.settings, 'Cài đặt tài khoản', 3),
                  _buildDrawerItem(Icons.call, 'CSKH 24/7', 4),
                  _buildDrawerItem(Icons.checklist, 'Chính sách & Điều khoản', 5),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.logout,color: Colors.white,),
                label: const Text('Đăng xuất'),
                onPressed: () => _showLogoutConfirmationDialog(context),
              ),
            ),
          ],
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: screens[currentIndex],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: currentIndex == index ? Colors.blueAccent : Colors.black54),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: currentIndex == index ? Colors.blueAccent : Colors.black87,
        ),
      ),
      selected: currentIndex == index,
      //selectedTileColor: Colors.grey.shade100,
      onTap: () {
        setState(() {
          currentIndex = index;
        });
        Navigator.pop(context);
      },
    );
  }
}
