import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pack_tracker/pages/create_new_tracking_page.dart';
import 'package:pack_tracker/pages/start_page.dart';
import 'package:pack_tracker/widgets/find_package.dart';
import 'package:pack_tracker/widgets/services.dart';

class HomePage extends StatefulWidget {
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  const HomePage({
    super.key,
    required this.db,
    required this.auth,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

// HOMEPAGE AREA

class _HomePageState extends State<HomePage> {
  bool production = false;
  var userInfo;
  Future getDbData() async {
    await widget.db
        .collection("user")
        .doc(widget.auth.currentUser?.uid)
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        userInfo = doc.data() as Map<String, dynamic>;

        setState(() {
          production = false;
        });
      } else {
        setState(() {
          production = true;
        });
      }
    });
  }

  Future deleteByAccount(String? uid) async {
    int amount = 0;
    widget.db
        .collection("trackings")
        .where("user", isEqualTo: uid)
        .get()
        .then((docs) {
      for (var doc in docs.docs) {
        amount++;
        widget.db.collection("trackings").doc(doc.id).delete();
      }
    });
    widget.db
        .collection("quantity")
        .doc("trackings")
        .get()
        .then((DocumentSnapshot doc) {
      widget.db.collection("quantity").doc("trackings").update({
        "total": FieldValue.increment(-amount),
      });
    });
    widget.db.collection("quantity").doc("users").update({
      "total": FieldValue.increment(-1),
    });
  }

  Future deleteAccount() async {
    String password = '';
    String email = '';
    widget.db
        .collection("user")
        .doc(widget.auth.currentUser?.uid)
        .get()
        .then((DocumentSnapshot doc) {
      var data = doc.data() as Map<String, dynamic>;
      password = data["password"];
      email = data["email"];
    });
    widget.db.collection("user").doc(widget.auth.currentUser?.uid).delete();
    widget.auth.currentUser?.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: email, password: password));
    await widget.auth.currentUser?.delete();
  }

  @override
  void initState() {
    super.initState();
    getDbData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shadowColor: null,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white, size: 32),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.grey[200],
                    title: const Text(
                      'Create new shipment',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.grey[300]),
                              ),
                              child: Text("Cancel",
                                  style: TextStyle(
                                    color: Colors.deepPurple[400],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.3,
                                  )),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreateNewTrackingPage(
                                              db: widget.db,
                                              auth: widget.auth,
                                            )));
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.deepPurple[600])),
                              child: const Text("Create",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.3,
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add_circle_outline_outlined,
                  color: Colors.white)),
        ),
        title: const Text('PackTracker'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: IconButton(
                onPressed: () => {
                      production
                          ? widget.auth.signOut()
                          : showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.grey[200],
                                title: const Text(
                                  'Account Management',
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 20),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(userInfo["username"]),
                                        Text(userInfo["trackings"].toString()),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 20),
                                    ),
                                    Text(userInfo["email"]),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await deleteByAccount(
                                                widget.auth.currentUser?.uid);
                                            await deleteAccount();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => StartPage(
                                                  auth: widget.auth,
                                                  db: widget.db,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await widget.auth.signOut();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => StartPage(
                                                  auth: widget.auth,
                                                  db: widget.db,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.logout,
                                              color: Colors.deepPurple),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                    },
                icon: const Icon(Icons.account_circle_rounded)),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            FindPackage(
              db: widget.db,
              auth: widget.auth,
            ),
            Services(
              db: widget.db,
              auth: widget.auth,
            )
          ],
        ),
      ),
    );
  }
}
