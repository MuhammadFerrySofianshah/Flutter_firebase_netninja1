import 'package:flutter/material.dart';
import 'package:flutter_firebase_netninja/models/brew.dart';
import 'package:flutter_firebase_netninja/screens/authenticate/sign_in_email_pass/sign_in_email.dart';
import 'package:flutter_firebase_netninja/screens/home/brew_list.dart';
import 'package:flutter_firebase_netninja/screens/home/setting_form.dart';
import 'package:flutter_firebase_netninja/services/auth.dart';
import 'package:flutter_firebase_netninja/services/database.dart';
import 'package:flutter_firebase_netninja/widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final
  final AuthServices _firebaseAuth = AuthServices();

  void _tampilanSettingPanel() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: blueColor,
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height / 2,
          child: SettingForm(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dapatkan uid pengguna saat ini
    final uid = Provider.of<String?>(context);

    return StreamProvider<List<Brew>>.value(
      value: DatabaseServices(uid: uid).brews,
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          title: wText('Home', blackColor, 14, FontWeight.normal),
          backgroundColor: blueColor,
          actions: [
            TextButton.icon(
              onPressed: () async {
                await _firebaseAuth.signOut();
                wPushReplacement(context, SignInEmail());
              },
              icon: Icon(Icons.person, color: blackColor),
              label: wText('Logout', blackColor, 14, FontWeight.normal),
            ),
            TextButton.icon(
              onPressed: () async {
                _tampilanSettingPanel();
              },
              icon: Icon(Icons.settings, color: blackColor),
              label: wText('Setting', blackColor, 14, FontWeight.normal),
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
