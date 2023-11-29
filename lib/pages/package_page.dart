import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pack_tracker/pages/home_page.dart';
import 'package:pack_tracker/widgets/history.dart';
import 'package:pack_tracker/widgets/tracking.dart';

class PackagePage extends StatefulWidget {
  final String id;
  final Map<String, dynamic> info;
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  const PackagePage(
      {super.key,
      required this.id,
      required this.info,
      required this.db,
      required this.auth});

  @override
  State<PackagePage> createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shadowColor: null,
        elevation: 0,
        iconTheme:
            const IconThemeData(color: Colors.deepPurpleAccent, size: 32),
        backgroundColor: Colors.white,
        leading: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              db: widget.db,
                              auth: widget.auth,
                            )));
              },
              icon: const Icon(Icons.arrow_back_rounded),
              tooltip: 'Go back to the homepage',
            )),
        title: Text(widget.id),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.deepPurple,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.account_circle_rounded),
          )
        ],
      ),
      body: Center(
          child: Column(
        children: [
          Tracking(
            id: widget.id,
            info: widget.info,
            db: widget.db,
            auth: widget.auth,
          ),
          History(id: widget.id, info: widget.info, db: widget.db),
        ],
      )),
    );
  }
}
