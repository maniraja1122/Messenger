import 'package:flutter/material.dart';

import '../AppRoutes.dart';
import '../Widgets/RoundButton.dart';


class Selector extends StatelessWidget {
  const Selector({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Messenger",
                style: TextStyle(color: Colors.black, fontSize: 40,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5,),
              Text(
                "Chat like a pro",
                style: TextStyle(color: Colors.black54,fontSize: 15),
              ),
              SizedBox(
                height: 300,
              ),
              RoundButton(
                text: "Login",
                bacground: Colors.white,
                foreground: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.Login);
                },
              ),
              SizedBox(
                height: 10,
              ),
              RoundButton(
                text: "Sign Up",
                bacground: Colors.blue,
                foreground: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.Signup);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}