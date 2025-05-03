import 'package:flutter/material.dart';
import 'package:flutter_auth/pages/login.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  final String data;
  const Home({super.key, required this.data});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool darkMode = false;

  void toogleTheme() {
    setState(() {
      darkMode = !darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Center(
                child: SvgPicture.asset(
                  'assets/images/register.svg',
                  width: 300,
                ),
              ),
              SizedBox(height: 50),
              Text(
                "Halo " + widget.data,
                style: TextStyle(
                  color: darkMode ? Colors.white : Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              TextButton.icon(
                onPressed: toogleTheme,
                style: ButtonStyle(
                  iconSize: WidgetStatePropertyAll(30),
                  iconColor: WidgetStatePropertyAll(
                    darkMode ? Colors.white : Colors.black,
                  ),
                ),
                label: Icon(
                  darkMode
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                ),
              ),
              SizedBox(height: 30),
              // FilledButton(
              //   style: ButtonStyle(
              //     backgroundColor: WidgetStatePropertyAll(Colors.red),
              //   ),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => Login()),
              //     );
              //   },
              //   child: Text('Logout'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
