import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [const _PurpleBox(), const _LoginIcon(), child],
      ),
    );
  }
}

class _LoginIcon extends StatelessWidget {
  const _LoginIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SizedBox(
          width: double.infinity,
          height: 200,
          child: Icon(
            Icons.person_pin,
            size: 100,
            color: Colors.white,
          )),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  const _PurpleBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBackground(),
      child: Stack(
        children: const [
          Positioned(top: -30, left: 30, child: _Bubble()),
          Positioned(top: -40, left: 300, child: _Bubble()),
          Positioned(bottom: 51, left: 250, child: _Bubble()),
          Positioned(bottom: 100, left: 100, child: _Bubble()),
          Positioned(bottom: -60, left: 30, child: _Bubble()),
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() {
    return const BoxDecoration(
        gradient: LinearGradient(colors: [
      Color.fromARGB(255, 63, 63, 156),
      Color.fromARGB(255, 90, 70, 170)
    ]));
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
