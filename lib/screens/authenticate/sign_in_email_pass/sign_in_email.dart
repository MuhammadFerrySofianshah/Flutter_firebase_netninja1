import 'package:flutter/material.dart';
import 'package:flutter_firebase_netninja/loading.dart';
import 'package:flutter_firebase_netninja/screens/authenticate/sign_in_email_pass/register_email.dart';
import 'package:flutter_firebase_netninja/screens/home/home.dart';
import 'package:flutter_firebase_netninja/services/auth.dart';
import 'package:flutter_firebase_netninja/widget.dart';

class SignInEmail extends StatefulWidget {
  const SignInEmail({super.key});
  @override
  State<SignInEmail> createState() => _SignInEmailState();
}

class _SignInEmailState extends State<SignInEmail> {
  // final
  final AuthServices _firebaseAuth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  // bool
  bool loading = false;

  // text field State
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: blueColor,
              elevation: 0,
              title: wText('Sign In to Email', whiteColor, 16, FontWeight.bold),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      wPushReplacement(context, RegisterEmail());
                    },
                    icon: Icon(Icons.app_registration),
                    label: wText('Register', whiteColor, 14, FontWeight.normal))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Masukkan Email dulu...' : null,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (value) {
                        setState(() => email = value);
                      },
                    ),
                    TextFormField(
                      validator: (value) => value!.length < 6
                          ? 'Minimal pass 6 karakter...'
                          : null,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (value) {
                        setState(() => password = value);
                      },
                    ),
                    wSizedBoxHeight(20),
                    ElevatedButton(
                      child: Text('Sign In'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // loading
                          setState(() {
                            loading = true;
                          });
                          // signIn
                          dynamic result =
                              await _firebaseAuth.signInWithEmailPassword(
                                  context, email, password);
                          // error
                          if (result == null) {
                            setState(() {
                              error = 'could not signin with those credentials';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    wSizedBoxHeight(10),
                    wText(error, Colors.red, 12, FontWeight.normal)
                  ],
                ),
              ),
            ),
          );
  }
}
