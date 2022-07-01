import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos/env.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  Future<String?> signUp(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.https(Env.firebaseApiUrl, 'v1/accounts:signUp', {
      "key": Env.firebaseApiKey,
    });

    final response = await http.post(url, body: json.encode(authData));

    if (response.statusCode == 200) {
      return json.decode(response.body)['idToken'];
    }
    return null;
  }
}
