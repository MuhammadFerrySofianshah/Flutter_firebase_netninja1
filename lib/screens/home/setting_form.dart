
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_netninja/loading.dart';
import 'package:flutter_firebase_netninja/models/user_id.dart';
import 'package:flutter_firebase_netninja/services/database.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  final Key? key;

  const SettingForm({this.key}) : super(key: key);

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  late String currentName;
  late String currentSugars;
  int currentStrength = 100;
  // int currentStrength = 100;

  // @override
  // void initState() {
  //   super.initState();
  //   currentSugars = '1';
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseServices(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData? userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Update Your Brews Settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: InputDecoration(labelText: 'Enter your name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your name' : null,
                    onChanged: (value) => setState(() {
                      currentName = value;
                    }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: currentSugars,
                    items: sugars.map((e) {
                      return DropdownMenuItem(
                          value: currentSugars ?? userData.sugars,
                          child: Text(
                            '$e Sugars',
                            style: TextStyle(fontSize: 16),
                          ));
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        currentSugars = value!;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Slider(
                    value: (currentStrength).toDouble(),
                    activeColor:
                        Colors.blue[currentStrength],
                    inactiveColor:
                        Colors.blue[currentStrength],
                    min: 100,
                    max: 900,
                    onChanged: (value) {
                      setState(() {
                        currentStrength = currentStrength;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        DatabaseServices(uid: user.uid).updateUserData(
                            currentSugars, currentName, currentStrength);
                      }
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
