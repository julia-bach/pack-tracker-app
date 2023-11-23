import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pack_tracker/pages/create_new_tracking_page.dart';
import 'package:pack_tracker/pages/login.dart';
import 'package:pack_tracker/pages/register.dart';
import 'package:pack_tracker/widgets/find_package.dart';
import 'package:pack_tracker/widgets/services.dart';

class LoginInfo extends StatefulWidget {
  final FirebaseFirestore db;
  const LoginInfo({super.key, required this.db});

  @override
  State<LoginInfo> createState() => _LoginInfoState();
}

class _LoginInfoState extends State<LoginInfo> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  String email = '';
  String password = '';
  bool reveal = true;
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
                        borderSide: BorderSide(
                            color: Colors.deepPurpleAccent, width: 2),
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
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      color: Colors.grey[700],
                    )),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  onPressed: () {
                    email = controllerEmail.text;
                    password = controllerPassword.text;
                    controllerEmail.clear();
                    controllerPassword.clear();
                  },
                  child: const Text("Login",
                      style: TextStyle(color: Colors.deepPurple)),
                ),
              ],
            ),
          ),
        ),
      );
}
