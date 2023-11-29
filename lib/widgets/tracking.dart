import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pack_tracker/pages/home_page.dart';

class Tracking extends StatefulWidget {
  final String id;
  final Map<String, dynamic> info;
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  const Tracking(
      {super.key,
      required this.id,
      required this.info,
      required this.db,
      required this.auth});

  @override
  State<Tracking> createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  Future deleteById(String id) async {
    widget.db
        .collection("quantity")
        .doc("amount")
        .get()
        .then((DocumentSnapshot doc) {
      widget.db.collection("quantity").doc("amount").set({
        "total": doc["total"] - 1,
      });
    });

    await widget.db.collection("trackings").doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.info["title"],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    letterSpacing: 1.2,
                    height: 2),
                textAlign: TextAlign.start,
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.grey[200],
                      title: Text(
                        'Do you want to delete this shipment tracking?',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.indeterminate_check_box,
                              color: Colors.grey[400],
                              size: 65,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 40),
                          ),
                          IconButton(
                            onPressed: () {
                              String id = widget.id;
                              deleteById(id);
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.grey[200],
                                  title: Text(
                                    'Shipment $id was removed!',
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  content: TextButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.deepPurple),
                                        foregroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage(
                                                    db: widget.db,
                                                    auth: widget.auth,
                                                  )));
                                    },
                                    child: const Text("Go back to home page"),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.check_box,
                              color: Colors.deepPurple[600],
                              size: 65,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 30, bottom: 75),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                  size: 24,
                ),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 15, bottom: 15)),
          Column(
            children: [
              SentFrom(id: widget.id, info: widget.info),
              Fee(id: widget.id, info: widget.info),
              CurrentAt(id: widget.id, info: widget.info),
            ],
          ),
        ],
      ),
    );
  }
}

// SENT FROM THING

class SentFrom extends StatefulWidget {
  final String id;
  final Map<String, dynamic> info;
  const SentFrom({super.key, required this.id, required this.info});

  @override
  State<SentFrom> createState() => _SentFromState();
}

class _SentFromState extends State<SentFrom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        color: Colors.deepPurple,
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.info["from"],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    wordSpacing: 4,
                    letterSpacing: 1.2,
                    height: 1.5),
              ),
              Text(widget.info["residential"],
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      height: 2)),
            ],
          ),
          const Icon(Icons.markunread_mailbox_rounded, color: Colors.white),
        ],
      ),
    );
  }
}

// FEE THING

class Fee extends StatefulWidget {
  final String id;
  final Map<String, dynamic> info;
  const Fee({super.key, required this.id, required this.info});

  @override
  State<Fee> createState() => _FeeState();
}

class _FeeState extends State<Fee> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple[400],
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            color: Colors.white,
            size: 12,
          ),
          const Padding(padding: EdgeInsets.only(right: 7.5, left: 7.5)),
          const Text("-",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
          Text(widget.info["cost"],
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500)),
          const Padding(padding: EdgeInsets.only(right: 7.5, left: 7.5)),
          Text('USD       Our free (included)',
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 11,
                fontWeight: FontWeight.w300,
              ))
        ],
      ),
    );
  }
}

// CURRENT AT THING

class CurrentAt extends StatefulWidget {
  final String id;
  final Map<String, dynamic> info;
  const CurrentAt({super.key, required this.id, required this.info});

  @override
  State<CurrentAt> createState() => _CurrentAtState();
}

class _CurrentAtState extends State<CurrentAt> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          color: Colors.deepPurple),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.info["to"],
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                wordSpacing: 4,
                letterSpacing: 1.2,
                height: 1.5),
          ),
          Text("Parcel, ",
              style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  height: 2)),
          Text(widget.info["weight"],
              style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  height: 2)),
        ],
      ),
    );
  }
}
