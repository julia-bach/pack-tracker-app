import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pack_tracker/pages/home_page.dart';

class LoginInfo extends StatefulWidget {
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  const LoginInfo({super.key, required this.db, required this.auth});

  @override
  State<LoginInfo> createState() => _LoginInfoState();
}

class _LoginInfoState extends State<LoginInfo> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  String email = '';
  String password = '';
  bool reveal = true;

  Future logInUser() async {
    await widget.auth.signInWithEmailAndPassword(
        email: controllerEmail.text, password: controllerPassword.text);
    if (widget.auth.currentUser != null) {
      print(widget.auth.currentUser?.email);
      print('Is logged in');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    db: widget.db,
                    auth: widget.auth,
                  )));
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[200],
            title: Text(
              'Shipment created and will be tracked!',
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            content: Text('Login information does not match!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          decoration: const BoxDecoration(color: Colors.deepPurple),
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                const Text(
                  'Log in your account',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1),
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                ),
                TextField(
                  controller: controllerEmail,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide:
                          BorderSide(color: Colors.deepPurpleAccent, width: 2),
                    ),
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                TextField(
                  controller: controllerPassword,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide:
                          BorderSide(color: Colors.deepPurpleAccent, width: 2),
                    ),
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          reveal = !reveal;
                        });
                      },
                      icon: Icon(
                        reveal
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),
                  obscureText: reveal,
                  obscuringCharacter: '*',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                ElevatedButton(
                  onPressed: () {
                    logInUser();
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      minimumSize:
                          MaterialStatePropertyAll(Size.fromHeight(50)),
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
              ],
            ),
          ),
        ),
      );
}
