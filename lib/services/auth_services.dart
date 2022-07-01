import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos/env.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  Future<String?> signUp(String email, String password) async {
    // Cuerpo de la petición
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.https(Env.firebaseApiUrl, 'v1/accounts:signUp', {
      "key": Env.firebaseApiKey,
    });

    final response = await http.post(url, body: json.encode(authData));

    // se verifica si la respuesta es correcta o si hay un error
    if (response.statusCode == 200) {
      return json.decode(response.body)['idToken'];
    } else if (response.statusCode == 400) {
      throw Exception('El correo ya se encuentra registrado');
    } else {
      throw Exception('Ocurrió un error al registrarse');
    }
  }

  Future<String?> logIn(String email, String password) async {
    // Cuerpo de la petición
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url =
        Uri.https(Env.firebaseApiUrl, 'v1/accounts:signInWithPassword', {
      "key": Env.firebaseApiKey,
    });

    final response = await http.post(url, body: json.encode(authData));

    // se verifica si la respuesta es correcta o si hay un error
    if (response.statusCode == 200) {
      return json.decode(response.body)['idToken'];
    } else if (response.statusCode == 400) {
      throw Exception('El correo o la contraseña son incorrectos');
    } else {
      throw Exception('Ocurrió un error al iniciar sesión');
    }
  }
}
