import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_netninja/models/brew.dart';
import 'package:flutter_firebase_netninja/models/user_id.dart';

class DatabaseServices {
  final String? uid;
  DatabaseServices({required this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  // fireStore
  // saat melakukan registrasi otomatis data akan masuk ke cloud
  Future<void> updateUserData(String sugars, String name, int strength) async {
    await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brews list form snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>; // Menentukan tipe data
      return Brew(
        name: data['name'] ?? '',
        strength: data['strength'] ?? 0,
        sugars: data['sugars'] ?? '0',
      );
    }).toList();
  }

  // user data from snapshot
  UserData userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (data == null) {
    // Penanganan jika data null, misalnya memberikan nilai default
      return UserData(
        uid: uid!,
        name: '',
        sugars: '',
        strength: 0,
      );
    }

    return UserData(
      uid: uid!,
      name: data['name'] ?? '',
      sugars: data['sugars'] ?? '',
      strength: data['strength'] ?? 0,
    );
  }

  // GET BREWS STREAM
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map((_brewListFromSnapshot));
  }

  // GET USER DOC STREAM
  Stream<UserData> get userData {
    return brewCollection
        .doc(uid)
        .snapshots()
        .map((event) => userDataFromSnapshot(event));
  }
}
