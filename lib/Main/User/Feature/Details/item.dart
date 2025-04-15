import 'package:flutter/material.dart';
import 'package:food/Main/User/Feature/Controller/product_model.dart';
import 'package:intl/intl.dart';
class ItemsDetails extends StatelessWidget {
  final Product product;
  const ItemsDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              product.title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                Center(
                  child: Text(
                    "Giá : ${NumberFormat.currency(
                        locale: 'vi_VN',
                        symbol: 'VND',
                        decimalDigits: 0).format(product.price)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}