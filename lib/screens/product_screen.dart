import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  static const String routeName = '/product';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('ProductScreen'),
      ),
    );
  }
}
