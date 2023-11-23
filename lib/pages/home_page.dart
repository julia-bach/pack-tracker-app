import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pack_tracker/pages/create_new_tracking_page.dart';
import 'package:pack_tracker/pages/login.dart';
import 'package:pack_tracker/pages/register.dart';
import 'package:pack_tracker/widgets/find_package.dart';
import 'package:pack_tracker/widgets/services.dart';

class HomePage extends StatefulWidget {
  final FirebaseFirestore db;
  const HomePage({
    super.key,
    required this.db,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

// HOMEPAGE AREA

class _HomePageState extends State<HomePage> {
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
                      showDialog(
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
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LoginPage(
                                                    db: widget.db,
                                                  )));
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                      ),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.grey[300]),
                                    ),
                                    child: Text("Login",
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
                                                  RegisterPage(
                                                    db: widget.db,
                                                  )));
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.deepPurple[600])),
                                    child: const Text("Register",
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
                      )
                    },
                icon: const Icon(Icons.account_circle_rounded)),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [FindPackage(db: widget.db), Services(db: widget.db)],
        ),
      ),
    );
  }
}
