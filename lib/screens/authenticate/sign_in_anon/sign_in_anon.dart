import 'package:flutter/material.dart';
import 'package:flutter_firebase_netninja/screens/home/home.dart';
import 'package:flutter_firebase_netninja/services/auth.dart';
import 'package:flutter_firebase_netninja/widget.dart';

class SignInAnon extends StatefulWidget {
  const SignInAnon({super.key});

  @override
  State<SignInAnon> createState() => _SignInAnonState();
}

class _SignInAnonState extends State<SignInAnon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: blueColor,
        elevation: 0,
        title: wText('Sign In to Anonymous', whiteColor, 16, FontWeight.bold),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: ElevatedButton(
          child: Text('Sign In Anonymous'),
          onPressed: () async {
            try {
              dynamic result = await AuthServices().signInAnon();
              if (result == null) {
                wShowDialog(context, 'Login Failed', redColor);
              } else {
                wPushReplacement(context, Home());
                print(result);
              }
            } catch (e) {
              print("Error saat sign-in: $e");
              wShowDialog(context, 'Terjadi Kesalahan', orangeColor);
            }
          },
        ),
      ),
    );
  }
}
