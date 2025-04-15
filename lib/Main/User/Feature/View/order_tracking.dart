import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderTracking extends StatefulWidget {
  const OrderTracking({super.key});

  @override
  _OrderTrackingState createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  List<Map<String, dynamic>> purchaseHistory = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('purchase_history') ?? [];

    setState(() {
      purchaseHistory = history
          .map((item) => json.decode(item) as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded =
    purchaseHistory.map((order) => jsonEncode(order)).toList();
    await prefs.setStringList('purchase_history', encoded);
  }

  void _showEditDialog(int index) {
    final order = purchaseHistory[index];
    final nameController = TextEditingController(text: order['customer']);
    final phoneController = TextEditingController(text: order['phone']);
    final addressController = TextEditingController(text: order['address']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sửa thông tin giao hàng"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Tên khách hàng",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Số điện thoại",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: "Địa chỉ",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Huỷ"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Lưu"),
            onPressed: () async {
              setState(() {
                purchaseHistory[index]['customer'] = nameController.text;
                purchaseHistory[index]['phone'] = phoneController.text;
                purchaseHistory[index]['address'] = addressController.text;
              });
              await saveHistory();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Cập nhật đơn hàng thành công.")),
              );
            },
          ),
        ],
      ),
    );
  }

  void _cancelOrder(int index) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Huỷ đơn hàng"),
        content: const Text("Bạn có chắc chắn muốn huỷ đơn hàng này không?"),
        actions: [
          TextButton(
            child: const Text("Không"),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Huỷ đơn", style: TextStyle(color: Colors.white),),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        purchaseHistory.removeAt(index);
      });
      await saveHistory();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đơn hàng đã được huỷ.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Đơn hàng của bạn')),
        automaticallyImplyLeading: false,
      ),
      body: purchaseHistory.isEmpty
          ? const Center(child: Text("Chưa có đơn hàng nào."))
          : ListView.builder(
        itemCount: purchaseHistory.length,
        itemBuilder: (context, index) {
          final order = purchaseHistory[index];
          return Card(
            margin:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.local_shipping,
                        color: Colors.green),
                    title: Text("Tên khách: ${order['customer']}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("SĐT: ${order['phone']}"),
                        Text("Địa chỉ: ${order['address']}"),
                        Text("Thanh toán: ${order['payment']}"),
                        Text("Tổng tiền: ${order['total']}₫"),
                        Text("Trạng thái: ${order['status']}"),
                        Text(
                            "Thời gian: ${DateTime.parse(order['timestamp']).toLocal()}"),
                      ],
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => _showEditDialog(index),
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        label: const Text("Sửa thông tin",
                            style: TextStyle(color: Colors.blue)),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => _cancelOrder(index),
                        icon:
                        const Icon(Icons.cancel, color: Colors.red),
                        label: const Text("Huỷ đơn",
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
