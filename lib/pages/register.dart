import 'package:flutter/material.dart';
import 'package:flutter_auth/constants/api.dart';
import 'package:flutter_auth/hooks/use-lokal.dart';
import 'package:flutter_auth/pages/login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool show_password = true;
  bool loading = false;
  bool rememberMe = false;
  String message = '';

  Future register() async {
    setState(() {
      loading = true;
      message = '';
    });
    final req = await http.post(
      Uri.parse(Api.register),
      headers: {
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        'username': username.text,
        'password': password.text
      })
    );

    if(req.statusCode == 200) {
      final data = jsonDecode(req.body);
      saveLocal('user', jsonEncode(data));
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      setState(() {
        message = 'Username or password invalid!';
      });
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/register.svg', width: 300)
                  ],
                ),
                SizedBox(height: 30),
                Text('Register', style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 50
                )),
                Text('Fill this form to register new account', style: TextStyle(
                  fontSize: 16
                )),
                SizedBox(height: message != '' ? 30 : 0),
                Center(
                  child: Text(message, style: TextStyle(
                    fontSize: 16,
                    color: Colors.red
                  )),
                ),
                SizedBox(height: message != '' ? 30 : 0),
                TextField(
                  autofocus: true,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    hintText: 'username',
                    prefixIcon: Icon(Icons.account_circle_outlined)
                  ),
                  controller: username,
                ),
                SizedBox(height: 20),
                TextField(
                  autofocus: true,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    hintText: 'email',
                    prefixIcon: Icon(Icons.email_outlined)
                  ),
                  controller: username,
                ),
                SizedBox(height: 20),
                TextField(
                  autofocus: true,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.done,
                  obscureText: show_password,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    hintText: 'password',
                    prefixIcon: Icon(Icons.password_outlined),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          show_password = !show_password;
                        });
                      },
                      icon: Icon(show_password ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                    ),
                  ),
                  controller: password,
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: FilledButton(
                    onPressed: loading ? null : register, 
                    child: Text(loading ? 'Loading...' : 'Register', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ))
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    SizedBox(width: 0),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text('Login    ')
                    )
                  ],
                ),
              ],
            )
          ),
        )
      )
    );
  
  }
}