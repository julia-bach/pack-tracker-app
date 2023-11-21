import 'package:pack_tracker/pages/home_page.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateNewTrackingPage extends StatefulWidget {
  final FirebaseFirestore db;
  const CreateNewTrackingPage({super.key, required this.db});

  @override
  State<CreateNewTrackingPage> createState() => _CreateNewTrackingPageState();
}

class _CreateNewTrackingPageState extends State<CreateNewTrackingPage> {
  int id = 0;
  String title = '';
  String city1 = '';
  String country1 = '';
  String city3 = '';
  String country3 = '';
  String city2 = '';
  String country2 = '';
  String residential = "";
  String cost = "";
  String weight = "";
  int updateCounter = 0;
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerCity1 = TextEditingController();
  TextEditingController _controllerCountry1 = TextEditingController();
  TextEditingController _controllerCity3 = TextEditingController();
  TextEditingController _controllerCountry3 = TextEditingController();
  TextEditingController _controllerCity2 = TextEditingController();
  TextEditingController _controllerCountry2 = TextEditingController();
  TextEditingController _controllerResidential = TextEditingController();
  TextEditingController _controllerCost = TextEditingController();
  TextEditingController _controllerWeight = TextEditingController();

  Future sendData(int id) async {
    await widget.db.collection("trackings").doc("$id").set({
      "title": title,
      "from": "$city1, $country1",
      "to": "$city2, $country2",
      "and": "$city3, $country3",
      "cost": cost,
      "weight": weight,
      "residential": residential,
      "updateCounter": updateCounter,
    });
    final docRef = widget.db.collection("quantity").doc("amount");
    docRef.get().then((DocumentSnapshot doc) {
      if (!doc.exists) {
        widget.db.collection("quantity").doc("amount").set({
          "total": 1,
        });
      } else {
        final data = doc.data() as Map<String, dynamic>;
        widget.db.collection("quantity").doc("amount").set({
          "total": data["total"] + 1,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            shadowColor: Colors.deepPurpleAccent,
            elevation: 2,
            backgroundColor: Colors.deepPurple,
            title: const Text("Create new shipment tracking"),
            centerTitle: true,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(bottom: 60)),
                      const Text("How should we call this shipment?",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Expanded(
                        child: TextField(
                          controller: _controllerTitle,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'Title',
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 45)),
                      const Text("Where does it come from?",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controllerCity1,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                labelText: 'City',
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 20)),
                          Expanded(
                            child: TextField(
                              controller: _controllerCountry1,
                              textInputAction: TextInputAction.next,
                              decoration:
                                  const InputDecoration(labelText: 'Country'),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 45)),
                      const Text("What is the residential number for it?",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Expanded(
                        child: TextField(
                          controller: _controllerResidential,
                          maxLength: 10,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: '10 digit number',
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 45)),
                      const Text("What's the destination?",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controllerCity2,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                labelText: 'City',
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 20)),
                          Expanded(
                            child: TextField(
                              controller: _controllerCountry2,
                              textInputAction: TextInputAction.next,
                              decoration:
                                  const InputDecoration(labelText: 'Country'),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 45)),
                      const Text("How much does it weight?",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Expanded(
                        child: TextField(
                          controller: _controllerWeight,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Weight',
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 45)),
                      const Text("Where's going to be its stop?",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controllerCity3,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                labelText: 'City',
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 20)),
                          Expanded(
                            child: TextField(
                              controller: _controllerCountry3,
                              textInputAction: TextInputAction.next,
                              decoration:
                                  const InputDecoration(labelText: 'Country'),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 45)),
                      const Text("How much will it cost?",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Expanded(
                        child: TextField(
                          controller: _controllerCost,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Cost',
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          updateCounter = 1;
                          var rng = Random();
                          id = rng.nextInt(900000) + 100000;
                          title = _controllerTitle.text;
                          cost = _controllerCost.text;
                          weight = _controllerWeight.text;
                          residential = _controllerResidential.text;
                          city1 = _controllerCity1.text;
                          city2 = _controllerCity2.text;
                          city3 = _controllerCity3.text;
                          country1 = _controllerCountry1.text;
                          country2 = _controllerCountry2.text;
                          country3 = _controllerCountry3.text;
                          if (title == "" ||
                              cost == "" ||
                              weight == "" ||
                              residential == "" ||
                              city1 == "" ||
                              city2 == "" ||
                              city3 == "" ||
                              country1 == "" ||
                              country2 == "" ||
                              country3 == "") {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.grey[200],
                                title: Text(
                                  'Some information are missing!',
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                content: TextButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.deepPurple),
                                      foregroundColor: MaterialStatePropertyAll(
                                          Colors.white)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Finish filling"),
                                ),
                              ),
                            );
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
                                content: TextButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.deepPurple),
                                      foregroundColor: MaterialStatePropertyAll(
                                          Colors.white)),
                                  onPressed: () {
                                    sendData(id);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomePage(db: widget.db)));
                                  },
                                  child: const Text("Go back home"),
                                ),
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.deepPurple[400]),
                          minimumSize: const MaterialStatePropertyAll(
                              Size.fromHeight(40)),
                        ),
                        child: const Text("Create",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                letterSpacing: 1.5)),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
