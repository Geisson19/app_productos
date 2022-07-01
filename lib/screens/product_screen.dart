import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos/providers/product_form_provider.dart';
import 'package:productos/services/products_service.dart';
import 'package:productos/ui/input_decoration.dart';
import 'package:productos/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  static const String routeName = '/product';

  @override
  Widget build(BuildContext context) {
    final ProductsService productsService =
        Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productsService.selectedProduct),
      child: _ProductScreenBody(productsService: productsService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productsService,
  }) : super(key: key);

  final ProductsService productsService;

  @override
  Widget build(BuildContext context) {
    final ProductFormProvider productFormProvider =
        Provider.of<ProductFormProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ProductImage(productsService.selectedProduct.picture),
                  const _BackArrow(),
                  const _GalleryButton()
                ],
              ),
              const _ProductInfo(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!productFormProvider.isValid()) return;
          productsService.createOrUpdate(productFormProvider.product);
        },
        child: const Icon(Icons.save_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}

class _GalleryButton extends StatelessWidget {
  const _GalleryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      right: 20,
      child: IconButton(
        icon: const Icon(Icons.camera_enhance, color: Colors.white, size: 30),
        onPressed: () {
          // TODO: Camera button
        },
      ),
    );
  }
}

class _BackArrow extends StatelessWidget {
  const _BackArrow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 60,
        left: 20,
        child: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ));
  }
}

class _ProductInfo extends StatelessWidget {
  const _ProductInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductFormProvider productFormProvider =
        Provider.of<ProductFormProvider>(context);
    final currentProduct = productFormProvider.product;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: _infoDecoration(),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: productFormProvider.formKey,
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              initialValue: currentProduct.name,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'El nombre es obligatorio';
                }
                return null;
              },
              onChanged: (value) {
                currentProduct.name = value;
              },
              decoration: InputDecorations.authInputDecoration(
                  hintText: "Nombre del producto", labelText: "Nombre: "),
            ),
            const SizedBox(height: 30),
            TextFormField(
              initialValue: '${currentProduct.price}',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
              onChanged: (value) {
                if (double.tryParse(value) != null) {
                  currentProduct.price = double.parse(value);
                } else {
                  currentProduct.price = 0;
                }
              },
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                  hintText: "\$150", labelText: "Precio: "),
            ),
            const SizedBox(height: 30),
            SwitchListTile.adaptive(
                value: currentProduct.available,
                onChanged: (value) {
                  productFormProvider.setAvailable(value);
                },
                title: const Text("Disponible")),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  BoxDecoration _infoDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          offset: const Offset(0, 5),
          blurRadius: 5,
        ),
      ],
    );
  }
}
