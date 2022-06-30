import 'package:flutter/material.dart';
import 'package:productos/models/models.dart';
import 'package:productos/screens/screens.dart';
import 'package:productos/services/services.dart';
import 'package:productos/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final ProductsService productsService =
        Provider.of<ProductsService>(context);

    if (productsService.isLoading) return const LoadingScreen();

    List<ProductModel> products = productsService.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => GestureDetector(
            onTap: () => Navigator.pushNamed(context, ProductScreen.routeName),
            child: ProductCard(products[index])),
        itemCount: products.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
