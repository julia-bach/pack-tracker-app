import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Services extends StatefulWidget {
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  final bool listen;
  const Services({
    super.key,
    required this.db,
    required this.auth,
    required this.listen,
  });

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  var ids = [];
  var titles = [];
  var updates = [];
  int amount = 0;
  int qnt = 0;
  bool reloaded = false;
  Future getDbData(bool listen) async {
    qnt = 0;
    if (listen) {
      final docRef = widget.db
          .collection("trackings")
          .where("user", isEqualTo: widget.auth.currentUser?.uid);
      docRef.snapshots().listen((event) {
        for (var item in event.docs) {
          final data = item.data() as Map<String, dynamic>;
          ids.add(item.id);
          titles.add(data["title"]);
          updates.add(data["updateCounter"]);
          qnt++;
        }
        setState(() {
          amount = qnt;
        });
      });
    }
    setState(() {
      reloaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 40)),
        Row(
          children: [
            const Padding(padding: EdgeInsets.only(left: 20)),
            const Text(
              'My shipments',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Padding(padding: EdgeInsets.only(left: 60, right: 60)),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    getDbData(widget.listen);
                  },
                  child: const Text('View all',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.deepPurpleAccent)),
                ),
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.deepPurpleAccent,
                  size: 16,
                )
              ],
            ),
            const Padding(padding: EdgeInsets.only(right: 20)),
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 20)),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                reloaded
                    ? Card(
                        db: widget.db,
                        auth: widget.auth,
                        amount: amount,
                        ids: ids,
                        titles: titles,
                        updates: updates)
                    : ElevatedButton(
                        onPressed: () {
                          getDbData(widget.listen);
                        },
                        child: const Text('Fetch data'))
              ],
            ))
      ],
    );
  }
}

// CARDS FOR THE MY SERVICE AREA

class Card extends StatefulWidget {
  final ids;
  final titles;
  final updates;
  final amount;
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  const Card({
    super.key,
    required this.db,
    required this.auth,
    this.ids,
    this.titles,
    this.updates,
    this.amount,
  });
  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  String getImage(int progress) {
    if (progress == 2) {
      return "assets/images/in_transit.png";
    }
    if (progress == 3) {
      return "assets/images/received.png";
    } else {
      return "assets/images/sent.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          for (int i = 0; i < widget.amount; i++)
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 10)),
                SizedBox(
                  width: 125,
                  height: 175,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(getImage(widget.updates[i]))),
                      Text(
                        widget.titles[i],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        widget.ids[i],
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 10)),
              ],
            )
        ],
      ),
    );
  }
}
