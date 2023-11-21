import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Services extends StatefulWidget {
  final FirebaseFirestore db;
  const Services({
    super.key,
    required this.db,
  });

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 40)),
        const Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 20)),
            Text(
              'My shipments',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(padding: EdgeInsets.only(left: 70, right: 70)),
            Row(
              children: [
                Text(
                  'View all',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.deepPurpleAccent),
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.deepPurpleAccent,
                  size: 16,
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(right: 20)),
          ],
        ),
        Padding(padding: EdgeInsets.only(bottom: 20)),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Card(db: widget.db),
              ],
            ))
      ],
    );
  }
}

// CARDS FOR THE MY SERVICE AREA

class Card extends StatefulWidget {
  final FirebaseFirestore db;
  const Card({
    super.key,
    required this.db,
  });
  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  var ids = [];
  var titles = [];
  var updates = [];
  int amount = 0;
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

  Future getDbData() async {
    final docRef = widget.db.collection("trackings");
    docRef.snapshots().listen((event) {
      for (var item in event.docs) {
        final data = item.data() as Map<String, dynamic>;
        ids.add(item.id);
        titles.add(data["title"]);
        updates.add(data["updateCounter"]);
        amount++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getDbData();
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          for (int i = 0; i < amount; i++)
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
                          child: Image.asset(getImage(updates[i]))),
                      Text(
                        titles[i],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        ids[i],
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
