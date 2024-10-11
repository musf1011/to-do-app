import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProfInfoSir extends StatefulWidget {
  const ProfInfoSir({super.key});

  @override
  State<ProfInfoSir> createState() => _ProfInfoSirState();
}

String name = '';
String email = '';
FirebaseAuth auth = FirebaseAuth.instance;

//FirebaseDatabase _database = FirebaseDatabase.instance.ref('userDetail');
final _database = FirebaseDatabase.instanceFor(
  app: Firebase.app(),
  databaseURL: "https://to-do-app-dc50e-default-rtdb.firebaseio.com",
).ref('userDetails');

void initState() {
  // super.initState();
  var snaps = _database.child(FirebaseAuth.instance.currentUser!.uid).get();
  // if(snaps.child('name').value.toString)
}

class _ProfInfoSirState extends State<ProfInfoSir> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
