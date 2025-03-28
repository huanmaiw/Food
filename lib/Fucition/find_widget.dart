import 'package:flutter/material.dart';

class FindWidget extends StatefulWidget {
  const FindWidget({super.key});

  @override
  State<FindWidget> createState() => _FindWidgetState();
}

class _FindWidgetState extends State<FindWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Tìm kiếm...",
              hintStyle: TextStyle(color: Colors.grey.shade600),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              suffixIcon: Icon(Icons.search, color: Colors.blueAccent),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, color: Colors.blueAccent),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: Text(
          'Tìm kiếm sản phẩm hoặc dịch vụ',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
        ),
      ),
    );
  }
}