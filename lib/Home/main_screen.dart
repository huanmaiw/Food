import 'package:flutter/material.dart';
import 'package:food/Fucition/transport.dart';
import '../Fucition/cart_shopping.dart';
import '../Fucition/profile_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex =0;
  final List<Widget> screens=[
    HomeScreen(),
    CartShopping(),
    Transport(),
    ProfileScreen(),
  ];
  void _onSeclected(int index){
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        iconSize: 30,
        elevation: 5,
        onTap: _onSeclected,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: currentIndex == 0 ? Colors.blue : Colors.grey),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,
                color: currentIndex == 1 ? Colors.blue : Colors.grey),
            label: "Giỏ hàng",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping,
                color: currentIndex == 2 ? Colors.blue : Colors.grey),
            label: "Đơn hàng",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: currentIndex == 3 ? Colors.blue : Colors.grey),
            label: "Tài khoản",
          ),
        ],
        currentIndex: currentIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
          onPressed:(){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }, child: Icon(Icons.add,color: Colors.blue,),
           ),
    );
  }}