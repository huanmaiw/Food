
import 'package:flutter/material.dart';

class CartShopping extends StatefulWidget {
  const CartShopping({super.key});

  @override
  State<CartShopping> createState() => _CartShoppingState();
}

class _CartShoppingState extends State<CartShopping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng"),
        automaticallyImplyLeading: false, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Chưa có sản phẩm nào"),
      ),
    );
  }
}
