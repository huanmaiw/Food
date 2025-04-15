import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food/Main/User/Feature/Controller/product_model.dart';
import 'package:food/Main/User/Feature/View/screen.dart';
import 'package:food/Main/User/Feature/Controller/setting_account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../View/contants.dart';
import 'favorite_provider.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final TextEditingController _couponController = TextEditingController();

  void _applyCoupon() {
    final provider = FavoriteProvider.of(context, listen: false);
    final code = _couponController.text.trim();

    provider.applyDiscountCode(code);

    if (provider.discountPercent > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Áp dụng mã $code - giảm ${provider.discountPercent.toInt()}%")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mã không hợp lệ")),
      );
    }
  }
  void _checkout(double totalPrice) async {
    final prefs = await SharedPreferences.getInstance();

    final String name = prefs.getString('user_name') ?? 'Người dùng';
    final String phone = prefs.getString('user_phone') ?? 'Chưa có SĐT';
    final String address = prefs.getString('user_address') ?? 'Chưa có địa chỉ';

    final TextEditingController voucherController = TextEditingController();
    String selectedPaymentMethod = 'Thanh toán khi nhận hàng';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const Text(
                  "Xác nhận thanh toán",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                _buildReadOnlyInfoRow(Icons.person, "Tên khách hàng", name),
                _buildReadOnlyInfoRow(Icons.phone, "Số điện thoại", phone),
                _buildReadOnlyInfoRow(Icons.location_on, "Địa chỉ giao hàng", address),

                const SizedBox(height: 15),

                DropdownButtonFormField<String>(
                  value: selectedPaymentMethod,
                  decoration: InputDecoration(
                    labelText: "Phương thức thanh toán",
                    prefixIcon: const Icon(Icons.payment),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: ['Thanh toán khi nhận hàng', 'Ví tài khoản']
                      .map((method) => DropdownMenuItem(
                    value: method,
                    child: Text(method),
                  ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      selectedPaymentMethod = value;
                    }
                  },
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingAccount()));
                },
                    child: Text("Sửa thông tin nhận hàng")),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check_circle_outline),
                    label: Text("Xác nhận - ${totalPrice.toStringAsFixed(0)}₫",style: TextStyle(fontWeight: FontWeight.bold),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);

                      final order = {
                        'customer': name,
                        'phone': phone,
                        'address': address,
                        'payment': selectedPaymentMethod,
                        'voucher': voucherController.text.trim(),
                        'status': 'Đang giao',
                        'timestamp': DateTime.now().toIso8601String(),
                        'total': totalPrice.toStringAsFixed(0),
                      };
                      final history = prefs.getStringList('purchase_history') ?? [];
                      history.add(jsonEncode(order));
                      await prefs.setStringList('purchase_history', history);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Đặt hàng thành công!")),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildReadOnlyInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700]),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500)),
                Text(value,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // void _checkout(double totalPrice) {
  //
  //   final _nameController = TextEditingController();
  //   final _phoneController = TextEditingController();
  //   final _addressController = TextEditingController();
  //   String _selectedPaymentMethod = 'Thanh toán khi nhận hàng';
  //
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) {
  //       return Padding(
  //         padding: EdgeInsets.only(
  //           bottom: MediaQuery.of(context).viewInsets.bottom,
  //           left: 20,
  //           right: 20,
  //           top: 20,
  //         ),
  //         child: SingleChildScrollView(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const Center(
  //                 child: Text(
  //                   "Thông tin thanh toán",
  //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               const SizedBox(height: 15),
  //               TextField(
  //                 controller: _nameController,
  //                 decoration: const InputDecoration(
  //                   labelText: "Tên khách hàng",
  //                   border: OutlineInputBorder(),
  //                 ),
  //               ),
  //               const SizedBox(height: 10),
  //
  //               TextField(
  //                 controller: _phoneController,
  //                 keyboardType: TextInputType.phone,
  //                 decoration: const InputDecoration(
  //                   labelText: "Số điện thoại",
  //                   border: OutlineInputBorder(),
  //                 ),
  //               ),
  //               const SizedBox(height: 10),
  //
  //               // Địa chỉ
  //               TextField(
  //                 controller: _addressController,
  //                 decoration: const InputDecoration(
  //                   labelText: "Địa điểm giao hàng",
  //                   border: OutlineInputBorder(),
  //                 ),
  //               ),
  //               const SizedBox(height: 10),
  //               DropdownButtonFormField<String>(
  //                 value: _selectedPaymentMethod,
  //                 decoration: const InputDecoration(
  //                   labelText: "Phương thức thanh toán",
  //                   border: OutlineInputBorder(),
  //                 ),
  //                 items: ['Thanh toán khi nhận hàng',
  //                   "Ví tài khoản ",]
  //                     .map((method) => DropdownMenuItem(
  //                   value: method,
  //                   child: Text(method),
  //                 ))
  //                     .toList(),
  //                 onChanged: (value) {
  //                   if (value != null) {
  //                     _selectedPaymentMethod = value;
  //                   }
  //                 },
  //               ),
  //               const SizedBox(height: 10),
  //               const SizedBox(height: 20),
  //               SizedBox(
  //                 width: double.infinity,
  //                 child: ElevatedButton.icon(
  //                   icon: const Icon(Icons.check_circle, color: Colors.white,),
  //                   label: Text("Xác nhận - ${totalPrice.toStringAsFixed(0)}₫",style: TextStyle(color: Colors.white),),
  //                   style: ElevatedButton.styleFrom(
  //                     padding: const EdgeInsets.symmetric(vertical: 16),
  //                     backgroundColor: Colors.green,
  //                   ),
  //                   onPressed: () {
  //
  //                     Navigator.pop(context);
  //                     ScaffoldMessenger.of(context).showSnackBar(
  //                       SnackBar(
  //                         content: Text(
  //                           "Đặt hàng thành công!\n"
  //                               "Tên: ${_nameController.text}, "
  //                               "SĐT: ${_phoneController.text}, "
  //                               "Thanh toán: $_selectedPaymentMethod",
  //                         ),
  //                         duration: const Duration(seconds: 3),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ),
  //               const SizedBox(height: 10),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  //
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    final List<Product> finalList = provider.getFavorites();
    final double discountedTotal = provider.getDiscountedTotal();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Giỏ hàng của bạn",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: finalList.isEmpty
          ? const Center(
        child: Text(
          "Giỏ hàng của bạn đang trống.",
          style: TextStyle(fontSize: 16),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: finalList.length,
              itemBuilder: (context, index) {
                final product = finalList[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(product: product),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                width: 85,
                                height: 85,
                                decoration: BoxDecoration(
                                  color: kcontentColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.asset(product.image[0]),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      "${product.price.toStringAsFixed(0)}₫",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove_circle_outline),
                                          onPressed: () {
                                            provider.decreaseQuantity(product);
                                          },
                                        ),
                                        Text(
                                          "${product.quantity}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add_circle_outline),
                                          onPressed: () {
                                            provider.increaseQuantity(product);
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        right: 35,
                        child: GestureDetector(
                          onTap: () {
                            provider.removeFavorite(product);
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Mã giảm giá
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _couponController,
                    decoration: InputDecoration(
                      hintText: 'Nhập mã giảm giá...',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _applyCoupon,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  ),
                  child: const Text(
                    "Áp dụng",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Tổng tiền + nút thanh toán
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Tổng cộng:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${discountedTotal.toStringAsFixed(0)}₫",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.payment),
                    label: const Text("Thanh toán"),
                    onPressed: () {
                      _checkout(discountedTotal);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
