import 'package:flutter/material.dart';
import 'package:productos/providers/login_form_provider.dart';
import 'package:productos/screens/screens.dart';
import 'package:productos/services/services.dart';
import 'package:productos/ui/input_decoration.dart';
import 'package:productos/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 250),
          CardContainer(
              child: Column(
            children: [
              const SizedBox(height: 10),
              Text("Ingreso", style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 30),
              ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                lazy: false,
                child: const _LoginForm(),
              ),
            ],
          )),
          const SizedBox(height: 50),
          AuthTextButton(
              text: 'Crear cuenta',
              onPressed: () =>
                  {Navigator.pushNamed(context, RegisterScreen.routeName)}),
          const SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => loginForm.email = value,
            decoration: InputDecorations.authInputDecoration(
                hintText: "jhondoe@gmail.com",
                labelText: "Correo electrónico",
                prefixIcon: Icons.email),
            validator: (value) {
              if (value != null && value.isEmpty) {
                return "El correo electrónico es requerido";
              }
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? "") ? null : "Correo inválido";
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              onChanged: (value) => loginForm.password = value,
              decoration: InputDecorations.authInputDecoration(
                  hintText: "*********",
                  labelText: "Contraseña",
                  prefixIcon: Icons.lock),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "La contraseña es requerida";
                }
                if (value != null && value.length < 6) {
                  return "La contraseña debe tener al menos 6 caracteres";
                }
                return null;
              }),
          const SizedBox(height: 30),
          MaterialButton(
              color: Colors.deepPurple,
              disabledColor: Colors.grey,
              elevation: 0,
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      final AuthService authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      try {
                        await authService.logIn(
                            loginForm.email, loginForm.password);
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.routeName);
                      } catch (e) {
                        loginForm.isLoading = false;
                        NotificationsService.showSnackbar(
                            e.toString().replaceAll("Exception: ", ""));
                      }

                      loginForm.isLoading = false;
                    },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(loginForm.isLoading ? "Cargando..." : "Ingresar",
                    style: const TextStyle(color: Colors.white, fontSize: 18)),
              )),
        ]));
  }
}
