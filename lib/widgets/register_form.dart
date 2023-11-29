import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pack_tracker/pages/start_page.dart';

class RegisterForm extends StatefulWidget {
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  const RegisterForm({super.key, required this.db, required this.auth});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();
  String username = ' ';
  String email = ' ';
  String password = ' ';
  bool reveal = true;
  bool confirmed = true;
  Future createAccount() async {
    print('pressed');
    if (controllerPassword.text == controllerConfirmPassword.text &&
        controllerPassword.text != '') {
      setState(() {
        confirmed = true;
      });
      await widget.auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await widget.auth
          .signInWithEmailAndPassword(email: email, password: password);
      await widget.db.collection('user').doc(widget.auth.currentUser?.uid).set({
        "username": username,
        "email": email,
        "password": password,
        "trackings": 0,
      });
      await widget.auth.signOut();
      final docRef = widget.db.collection("quantity").doc("users");
      docRef.get().then((DocumentSnapshot doc) {
        if (!doc.exists) {
          widget.db.collection("quantity").doc("users").set({
            "total": 1,
          });
        } else {
          final data = doc.data() as Map<String, dynamic>;
          widget.db.collection("quantity").doc("users").set({
            "total": data["total"] + 1,
          });
        }
      });
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[200],
          title: Text(
            'Account succesfully created!',
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 24,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: TextButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                foregroundColor: MaterialStatePropertyAll(Colors.white)),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StartPage(
                            db: widget.db,
                            auth: widget.auth,
                          )));
            },
            child: const Text("Go back"),
          ),
        ),
      );
    } else {
      setState(() {
        confirmed = false;
      });
      print('not equal');
    }
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
              color: Colors.white),
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                const Text(
                  'Create your new account',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      height: 1.1),
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.all(15),
                ),
                TextField(
                  controller: controllerUsername,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide:
                          BorderSide(color: Colors.deepPurpleAccent, width: 2),
                    ),
                    hintText: 'Username',
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
                  keyboardType: TextInputType.name,
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
                TextField(
                  controller: controllerConfirmPassword,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide:
                          BorderSide(color: Colors.deepPurpleAccent, width: 2),
                    ),
                    hintText: 'Confirm Password',
                    filled: true,
                    fillColor: Colors.white,
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
                confirmed
                    ? const Padding(
                        padding: EdgeInsets.all(0),
                      )
                    : const Text('Password does not match!',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.start),
                ElevatedButton(
                  onPressed: () {
                    username = controllerUsername.text;
                    email = controllerEmail.text;
                    password = controllerPassword.text;
                    createAccount();
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.deepPurple),
                      minimumSize:
                          MaterialStatePropertyAll(Size.fromHeight(50)),
                      elevation: MaterialStatePropertyAll(0),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      side: MaterialStatePropertyAll(
                          BorderSide(width: 2, color: Colors.deepPurple))),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        letterSpacing: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
