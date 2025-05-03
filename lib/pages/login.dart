import 'package:flutter/material.dart';
import 'package:flutter_auth/constants/api.dart';
import 'package:flutter_auth/hooks/use-lokal.dart';
import 'package:flutter_auth/pages/home.dart';
import 'package:flutter_auth/pages/register.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool show_password = true;
  bool loading = false;
  bool rememberMe = false;
  String message = '';

  Future login() async {
    setState(() {
      loading = true;
      message = '';
    });
    print(Api.login);
    final req = await http.post(
      Uri.parse(Api.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username.text, 'password': password.text}),
    );

    if (req.statusCode == 200) {
      final data = jsonDecode(req.body);
      saveLocal('user', jsonEncode(data));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home(data: username.text)),
      );
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
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/login.svg', width: 170),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 50),
                ),
                Text('Please Log in to continue'),
                SizedBox(height: message != '' ? 30 : 0),
                Center(
                  child: Text(message, style: TextStyle(color: Colors.red)),
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
                    prefixIcon: Icon(Icons.account_circle_outlined),
                  ),
                  controller: username,
                ),
                SizedBox(height: 20),
                TextField(
                  autofocus: true,
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: show_password,
                  textInputAction: TextInputAction.done,
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
                      icon: Icon(
                        show_password
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  controller: password,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     TextButton(
                //       style: TextButton.styleFrom(
                //         padding: EdgeInsets.zero
                //       ),
                //       onPressed: () {
                //         Navigator.push(context, MaterialPageRoute(builder: (context) => Splash()));
                //       },
                //       child: Text('Forgot password')
                //     ),
                //   ],
                // ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: FilledButton(
                    // onPressed: loading ? null : login,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(data: username.text),
                        ),
                      );
                    },
                    child: Text(
                      loading ? 'Loading...' : 'Log In',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(width: 0),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Text('Register'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
