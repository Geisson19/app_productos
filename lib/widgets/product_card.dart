import 'package:flutter/material.dart';
import 'package:productos/models/models.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
    this.product, {
    Key? key,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 50, top: 30),
        width: double.infinity,
        height: 400,
        decoration: _productDecoration(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _BackgroundImage(imageUrl: product.picture),
            _ProductDetails(product.name, product.id!),
            _CardPrice(product.price),
            if (!product.available) const _NotAvailable()
          ],
        ),
      ),
    );
  }

  BoxDecoration _productDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, 5),
          blurRadius: 10,
        ),
      ],
    );
  }
}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: 100,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.yellow[800],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: const FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'No disponible',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ));
  }
}

class _CardPrice extends StatelessWidget {
  const _CardPrice(
    this.price, {
    Key? key,
  }) : super(key: key);

  final double price;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        right: 0,
        child: Container(
          alignment: Alignment.center,
          width: 100,
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '\$$price',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ));
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails(
    this.name,
    this.id, {
    Key? key,
  }) : super(key: key);

  final String name;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _cardBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              id,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBoxDecoration() {
    return const BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    Key? key,
    this.imageUrl,
  }) : super(key: key);

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: FadeInImage(
          placeholder: const AssetImage("assets/jar-loading.gif"),
          image: (imageUrl == null)
              ? const AssetImage("assets/no-image.png")
              : NetworkImage(imageUrl!) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
