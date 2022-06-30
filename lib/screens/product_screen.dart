import 'package:flutter/material.dart';
import 'package:productos/ui/input_decoration.dart';
import 'package:productos/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  static const String routeName = '/product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: const [
                  ProductImage(),
                  _BackArrow(),
                  _GalleryButton()
                ],
              ),
              const _ProductInfo(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: _infoDecoration(),
      child: Form(
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecorations.authInputDecoration(
                  hintText: "Nombre del producto", labelText: "Nombre: "),
            ),
            const SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                  hintText: "\$150", labelText: "Precio: "),
            ),
            const SizedBox(height: 30),
            SwitchListTile.adaptive(
                value: true,
                onChanged: (value) {},
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
