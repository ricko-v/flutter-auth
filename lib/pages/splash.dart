import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/constants/api.dart';
import 'package:flutter_auth/hooks/use-lokal.dart';
import 'package:flutter_auth/pages/home.dart';
import 'package:flutter_auth/pages/login.dart';
import 'package:http/http.dart' as http;

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future checkAuth() async {
    await removeLocal('user');
    String? user = await getLocal('user');
    if(user == null) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
      });
    } else {
      final local = jsonDecode(user);
      final token = local['accessToken'];
      final req = await http.get(
        Uri.parse(Api.checkToken),
        headers: {
          'Authorization': 'Bearer $token'
        }
      );

      if(req.statusCode == 200) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(data: local['username'])));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator(),
            )
          ],
        )
      ),
    );
  }
}