import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Flutterfire());
}

class Flutterfire extends StatefulWidget {
  const Flutterfire({super.key});

  @override
  State<Flutterfire> createState() => _FlutterfireState();
}

class _FlutterfireState extends State<Flutterfire> {
  late DatabaseReference _dbref;

  @override
  void initState() {
    // TODO: implement initState
    _dbref = FirebaseDatabase.instance.ref();
    super.initState();
  }

  void adding() async {
    try {
      await _dbref.child('firetest').set(
        {
          '_id': 1,
          'name': 'parmode',
          'age': 26,
          'pensioner': true,
        },
      ).then((value) => print('added sucessfully'));
    } catch (e) {
      print('CAUGHT AN ERROR');
    }
  }

  var databaseResult = 'nodata';
  void read() async {
    try {
      await _dbref.once().then((dataSnapshot) {
        setState(() {
          databaseResult = dataSnapshot.snapshot.value.toString();
        });
      });
    } catch (e) {
      print('CAUGHT AN ERROR');
    }
  }

  void updating() async {
    try {
      await _dbref.child('firetest').set(
        {
          '_id': 2,
          'name': 'suresh',
          'age': 30,
          'pensioner': true,
        },
      ).then((value) => print('updated sucessfully'));
    } catch (e) {
      print('CAUGHT AN ERROR');
    }
  }

  void delete() async {
    try {
      await _dbref
          .child('firetest')
          .remove()
          .then((value) => print('deleted sucessfully'));
    } catch (e) {
      print('CAUGHT AN ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "http working",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          leading: BackButton(color: Colors.blueGrey),
          elevation: 5,
          centerTitle: true,
          title: Text("RealTime DB"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(databaseResult),
                ElevatedButton(
                  onPressed: () {
                    read();
                  },
                  child: Text("GET"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    adding();
                  },
                  child: Text("post"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    updating();
                  },
                  child: Text("PUT"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    delete();
                  },
                  child: Text("DELTE"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
