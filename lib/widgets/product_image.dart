import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage(this.imageUrl, {Key? key}) : super(key: key);

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Container(
        decoration: _productImageDecoration(),
        height: 450,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          child: FadeInImage(
            image: imageUrl != null
                ? NetworkImage(imageUrl!) as ImageProvider
                : const AssetImage('assets/no-image.png'),
            placeholder: const AssetImage('assets/jar-loading.gif'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  BoxDecoration _productImageDecoration() {
    return BoxDecoration(
        color: Colors.red,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(45), topRight: Radius.circular(45)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5))
        ]);
  }
}
