import 'package:flutter/material.dart';
import 'package:food/Provider/provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CountProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Provider Example')),
      body: Center(child: Text('Count: ${counter.cout}')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.tanggia(),
        child: Icon(Icons.add),
      ),
    );
  }

}
