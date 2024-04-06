
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_netninja/widget.dart';

class AnonSignInPage extends StatelessWidget {
  const AnonSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* TITLE
            Text(
              'SIGN IN ANONYMOUSLY',
              style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            //* SIGN IN STATUS
            // CODE HERE: Mengubah status berdasarkan pengguna saat ini
            // StreamBuilder<User?>(
            //   stream: FirebaseAuth.instance.userChanges(),
            //   builder: (context, snapshot) {
            //     if(snapshot.hasData){
            //     return Text('SIGNED IN : ${snapshot.data?.uid}');
            //     } else {
            //     return const Text("Kamu belum masuk.");
            //     }
            //   }
            // ),
            const SizedBox(height: 15),

            //* SIGN IN BUTTON
            SizedBox(
              width: 150,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue.shade900)),
                  onPressed: () {
                    // CODE HERE: Sign in anonymously / Sign out dari firebase
                    if (FirebaseAuth.instance.currentUser != null) {
                      FirebaseAuth.instance.signOut();
                    } else {
                      FirebaseAuth.instance.signInAnonymously();
                    }
                  },
                  // CODE HERE: Ubah teks tombol berdasarkan pengguna saat ini
                  child: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.userChanges(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                      return const Text("Sign Out",
                          style: TextStyle(color: Colors.white));
                      }
                      return const Text("Sign In",
                          style: TextStyle(color: Colors.white));
                    }
                  )),
            )
          ],
        ),
      ),
    );
  }
}
