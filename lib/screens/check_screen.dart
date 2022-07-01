import 'package:flutter/material.dart';
import 'package:productos/screens/screens.dart';
import 'package:productos/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    final AuthService authService =
        Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return const Text('');
            }
            if (snapshot.data != "") {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const HomeScreen(),
                        transitionDuration: const Duration(milliseconds: 0)));
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const LoginScreen(),
                        transitionDuration: const Duration(seconds: 0)));
              });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
