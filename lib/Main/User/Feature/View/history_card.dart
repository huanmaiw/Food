import 'package:flutter/material.dart';
import 'package:food/Main/User/Feature/Controller/top_up.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class TopUpHistoryScreen extends StatefulWidget {
  const TopUpHistoryScreen({super.key});

  @override
  _TopUpHistoryScreenState createState() => _TopUpHistoryScreenState();
}

class _TopUpHistoryScreenState extends State<TopUpHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Lịch sử nạp tiền'),
      ),
      body: Consumer<TopUpHistoryProvider>(
        builder: (context, topUpHistoryProvider, child) {

          final transactions = topUpHistoryProvider.transactions;

          // Kiểm tra xem có giao dịch nào không
          if (transactions.isEmpty) {
            return const Center(
              child: Text('Chưa có giao dịch nào'),
            );
          }

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return ListTile(
                title: Text(
                  'Số tiền: ${NumberFormat.currency(locale: 'vi_VN', symbol: 'VND', decimalDigits: 0).format(transaction.amount)}',
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ngày nạp: ${DateFormat('dd/MM/yyyy HH:mm').format(transaction.dateTime)}',
                    ),
                    Text('Loại thẻ: ${transaction.cardType}'), // Hiển thị loại thẻ
                    Text('Trạng thái: ${transaction.status}'), // Hiển thị trạng thái
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}