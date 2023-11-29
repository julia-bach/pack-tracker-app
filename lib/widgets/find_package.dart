import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pack_tracker/pages/home_page.dart';
import 'package:pack_tracker/pages/package_page.dart';

class FindPackage extends StatefulWidget {
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  const FindPackage({super.key, required this.db, required this.auth});

  @override
  State<FindPackage> createState() => _FindPackageState();
}

class _FindPackageState extends State<FindPackage> {
  final controlling = TextEditingController();
  Map<String, dynamic> data = {};
  String trackNumber = '';
  Future fetchData(String id) async {
    if (id == "") {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[200],
          title: const Text(
            'Shipment not found!',
            style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            db: widget.db,
                            auth: widget.auth,
                          )));
            },
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              backgroundColor: MaterialStatePropertyAll(Colors.grey[300]),
            ),
            child: Text("Go back",
                style: TextStyle(
                  color: Colors.deepPurple[400],
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.3,
                )),
          ),
        ),
      );
    }
    final docRef = widget.db.collection("trackings").doc(id);
    await docRef.get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        data = doc.data() as Map<String, dynamic>;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PackagePage(
                      id: trackNumber,
                      info: data,
                      db: widget.db,
                      auth: widget.auth,
                    )));
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[200],
            title: const Text(
              'Shipment not found!',
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            content: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              db: widget.db,
                              auth: widget.auth,
                            )));
              },
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                backgroundColor: MaterialStatePropertyAll(Colors.grey[300]),
              ),
              child: Text("Go back",
                  style: TextStyle(
                    color: Colors.deepPurple[400],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.3,
                  )),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              color: Colors.deepPurple),
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                const Text(
                  'Track your shipment\n on demand',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1),
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                Text(
                  'Please enter your tracking number.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[300],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                TextField(
                  controller: controlling,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide:
                          BorderSide(color: Colors.deepPurpleAccent, width: 2),
                    ),
                    hintText: 'Enter track number',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.keyboard_alt_outlined,
                      color: Colors.deepPurpleAccent,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        trackNumber = controlling.text;
                        fetchData(trackNumber);
                        controlling.clear();
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset('assets/images/shipment.png'),
                ),
              ],
            ),
          ),
        ),
      );
}
