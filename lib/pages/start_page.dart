import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pack_tracker/pages/login.dart';
import 'package:pack_tracker/pages/register.dart';

class StartPage extends StatefulWidget {
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  const StartPage({
    super.key,
    required this.db,
    required this.auth,
  });

  @override
  State<StartPage> createState() => _StartPageState();
}

// HOMEPAGE AREA

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shadowColor: null,
        elevation: 0,
        title: const Text('PackTracker'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.deepPurple,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset('assets/images/shipment.png'),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage(
                                db: widget.db,
                                auth: widget.auth,
                              )));
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    minimumSize: MaterialStatePropertyAll(Size.fromHeight(50)),
                    elevation: null,
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    side: MaterialStatePropertyAll(
                        BorderSide(width: 2, color: Colors.white))),
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      letterSpacing: 1.5),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterPage(
                                db: widget.db,
                                auth: widget.auth,
                              )));
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    minimumSize: MaterialStatePropertyAll(Size.fromHeight(50)),
                    elevation: null,
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    side: MaterialStatePropertyAll(
                        BorderSide(width: 2, color: Colors.white))),
                child: const Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      letterSpacing: 1.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
