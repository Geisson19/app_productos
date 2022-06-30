import 'package:flutter/material.dart';
import 'package:productos/screens/screens.dart';
import 'package:productos/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => GestureDetector(
            onTap: () => Navigator.pushNamed(context, ProductScreen.routeName),
            child: const ProductCard()),
        itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
