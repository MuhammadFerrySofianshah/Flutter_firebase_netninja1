import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_netninja/models/user_id.dart';
import 'package:flutter_firebase_netninja/screens/authenticate/sign_in_anon/sign_in_anon.dart';
import 'package:flutter_firebase_netninja/firebase_options.dart';
import 'package:flutter_firebase_netninja/screens/authenticate/sign_in_email_pass/sign_in_email.dart';
import 'package:flutter_firebase_netninja/screens/home/home.dart';
import 'package:flutter_firebase_netninja/services/auth.dart';
import 'package:flutter_firebase_netninja/test.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserID?>.value(
      initialData: UserID(),
      value: AuthServices().user,
      child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Firebase',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
                useMaterial3: true,
              ),
              home:  Home(),
            );
          }),
    );
    
  }
}
