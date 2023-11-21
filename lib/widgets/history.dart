import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  final String id;
  final Map<String, dynamic> info;
  final FirebaseFirestore db;
  const History(
      {super.key, required this.id, required this.info, required this.db});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 40,
        left: 20,
        right: 20,
      ),
      child: Column(
        children: [
          TitleH(
            id: widget.id,
            info: widget.info,
            db: widget.db,
          ),
          Logs(
            id: widget.id,
            info: widget.info,
            db: widget.db,
          )
        ],
      ),
    );
  }
}

// HISTORY TITLE
class TitleH extends StatefulWidget {
  final String id;
  final Map<String, dynamic> info;
  final FirebaseFirestore db;
  const TitleH(
      {super.key, required this.id, required this.info, required this.db});
  @override
  State<TitleH> createState() => _TitleHState();
}

class _TitleHState extends State<TitleH> {
  int evaluate = 1;
  Future setValue(String id, Map<String, dynamic> data) async {
    final docRef = widget.db.collection("trackings").doc(id);
    await docRef.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      docRef.set({
        "updateCounter": data["updateCounter"] + 1,
      }, SetOptions(merge: true));
      setState(() {
        evaluate = data["updateCounter"];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      evaluate = widget.info["updateCounter"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('History',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2)),
          Row(
            children: [
              evaluate < 2
                  ? TextButton(
                      onPressed: () {
                        setValue(widget.id, widget.info);
                      },
                      style: const ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(
                              Colors.deepPurpleAccent)),
                      child: const Text("Update tracking"),
                    )
                  : TextButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.grey)),
                      child: const Text("Shipment received"),
                    )
            ],
          ),
        ],
      ),
    );
  }
}

// HISTORY LOGS

class Logs extends StatefulWidget {
  final String id;
  final Map<String, dynamic> info;
  final FirebaseFirestore db;
  const Logs(
      {super.key, required this.id, required this.info, required this.db});

  @override
  State<Logs> createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  int evaluate = 0;
  var texts = [
    "Sent from - Sending city",
    "In transit - Mandatory stop",
    "Received - Recipient city"
  ];
  var time = ["03:21AM", "02:47AM", "12:38PM"];
  String getPlace(int i) {
    if (i == evaluate - 1) {
      return widget.info["to"];
    } else if (i == evaluate - 2) {
      return widget.info["and"];
    } else {
      return widget.info["from"];
    }
  }

  Future initiateState() async {
    final docRef = widget.db.collection("trackings").doc(widget.id);
    await docRef.get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          evaluate = data["updateCounter"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initiateState();
    setState(() {
      evaluate = widget.info["updateCounter"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          for (int i = evaluate - 1; i >= 0; i--)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            color: i == evaluate - 1
                                ? Colors.deepPurple
                                : Colors.grey[300],
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            Icons.upcoming,
                            color: i == evaluate - 1
                                ? Colors.white
                                : Colors.grey[700],
                            size: 40,
                          ),
                        ),
                        Center(
                          child: Container(
                            color: i == 0 ? Colors.white : Colors.grey[300],
                            height: 20,
                            width: 3,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          texts[i],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              wordSpacing: 2,
                              height: 1.5),
                        ),
                        Text(
                          getPlace(i),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              wordSpacing: 2,
                              height: 1.5),
                        ),
                        Center(
                          child: Container(
                            color: Colors.white,
                            height: 20,
                            width: 3,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          time[i],
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              wordSpacing: 2,
                              height: 2),
                          textAlign: TextAlign.end,
                        ),
                        Center(
                          child: Container(
                            color: Colors.white,
                            height: 20,
                            width: 3,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                // Padding(padding: EdgeInsets.only(bottom: 20))
              ],
            ),
        ],
      ),
    );
  }
}
