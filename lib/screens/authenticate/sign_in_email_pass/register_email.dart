import 'package:flutter/material.dart';
import 'package:flutter_firebase_netninja/loading.dart';
import 'package:flutter_firebase_netninja/screens/authenticate/sign_in_email_pass/sign_in_email.dart';
import 'package:flutter_firebase_netninja/services/auth.dart';
import 'package:flutter_firebase_netninja/widget.dart';

class RegisterEmail extends StatefulWidget {
  const RegisterEmail({super.key});

  @override
  State<RegisterEmail> createState() => _RegisterEmailState();
}

class _RegisterEmailState extends State<RegisterEmail> {
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
              title:
                  wText('Register to Email', whiteColor, 16, FontWeight.bold),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      wPushReplacement(context, SignInEmail());
                    },
                    icon: Icon(Icons.login),
                    label: wText('Sign In', whiteColor, 14, FontWeight.normal))
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
                      child: Text('Sign Up'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // loading
                          setState(() {
                            loading = true;
                          });
                          // register
                          dynamic result =
                              await _firebaseAuth.registerWithEmailPassword(
                                  context, email, password);
                          // error
                          if (result == null) {
                            setState(() {
                              error =
                                  'Please supply valid email. Exmaple: test@mail.com';
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
