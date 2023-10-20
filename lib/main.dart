import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PackTracker',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.white),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// HOMEPAGE AREA

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shadowColor: null,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white, size: 32),
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.grey[200],
                    title: const Text(
                      'Theme Switcher',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    content: const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.light_mode_rounded,
                        color: Colors.deepPurpleAccent,
                        size: 50,
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.window, color: Colors.white)),
        ),
        title: const Text('PackTracker'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 24.0),
            child: Icon(Icons.account_circle_rounded),
          )
        ],
      ),
      body: const Center(
        child: Column(
          children: [FindPackage(), Services()],
        ),
      ),
    );
  }
}

// INPUT AREA AND STUFF

class FindPackage extends StatefulWidget {
  const FindPackage({super.key});

  @override
  State<FindPackage> createState() => _FindPackageState();
}

class _FindPackageState extends State<FindPackage> {
  final controlling = TextEditingController();
  String trackNumber = '';
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              color: Colors.deepPurple),
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                const Text(
                  'Track your shipment\n on demand',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1),
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                Text(
                  'Please enter your tracking number.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[300],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                TextField(
                  controller: controlling,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide:
                          BorderSide(color: Colors.deepPurpleAccent, width: 2),
                    ),
                    hintText: 'Enter track number',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.keyboard_alt_outlined,
                      color: Colors.deepPurpleAccent,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        trackNumber = controlling.text;
                        controlling.clear();
                        if (trackNumber != '' && trackNumber == '0' ||
                            trackNumber == '1' ||
                            trackNumber == '2') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PackagePage(id: trackNumber)));
                        }
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset('assets/images/shipment.png'),
                ),
              ],
            ),
          ),
        ),
      );
}

// SERVICES AREA

class Services extends StatefulWidget {
  const Services({
    super.key,
  });

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 40)),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 20)),
            Text(
              'My Services',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(padding: EdgeInsets.only(left: 80, right: 80)),
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
              Padding(padding: EdgeInsets.only(left: 10)),
              Card(image: 'truck'),
              Card(image: 'package'),
              Card(image: 'truck'),
              Card(image: 'package'),
              Padding(padding: EdgeInsets.only(right: 10))
            ],
          ),
        )
      ],
    );
  }
}

// CARDS FOR THE MY SERVICE AREA

class Card extends StatefulWidget {
  final String image;
  const Card({super.key, required this.image});
  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey[100],
      ),
      child: SizedBox(
        width: 125,
        height: 175,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset('assets/images/${widget.image}.png')),
            if (widget.image == 'truck')
              const Text('Courier',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  )),
            if (widget.image == 'truck')
              const Text('50k+ courier',
                  style: TextStyle(
                    fontSize: 14,
                  )),
            if (widget.image == 'package')
              const Text('Shipping',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  )),
            if (widget.image == 'package')
              const Text(
                'Safe delivery',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------
// PACKAGE PAGE AREA

class PackagePage extends StatefulWidget {
  final String id;
  const PackagePage({super.key, required this.id});

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
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_rounded),
              tooltip: 'Go back to the homepage',
            )),
        title: Text('username'),
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
          Tracking(id: widget.id),
          History(id: widget.id),
        ],
      )),
    );
  }
}

// TRACKING SECTION

class Tracking extends StatefulWidget {
  final String id;
  const Tracking({super.key, required this.id});

  @override
  State<Tracking> createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tracking: ${widget.id}',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                letterSpacing: 1.2,
                height: 2),
            textAlign: TextAlign.start,
          ),
          const Padding(padding: EdgeInsets.only(top: 15, bottom: 15)),
          Column(
            children: [
              SentFrom(
                id: widget.id,
              ),
              Fee(
                id: widget.id,
              ),
              CurrentAt(
                id: widget.id,
              ),
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
  const SentFrom({super.key, required this.id});

  @override
  State<SentFrom> createState() => _SentFromState();
}

class _SentFromState extends State<SentFrom> {
  List<String> cities = [
    'Sukabumi, Indonesia',
    'São Paulo, Brazil',
    'New York, USA'
  ];
  List<String> numbers = [
    'No resi 0123456789',
    'No resi 9876543210',
    'No resi 4663880000',
  ];
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
                cities[int.parse(widget.id)],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    wordSpacing: 4,
                    letterSpacing: 1.2,
                    height: 1.5),
              ),
              Text(numbers[int.parse(widget.id)],
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      height: 2)),
            ],
          ),
          const Icon(
            Icons.markunread_mailbox_rounded,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

// FEE THING

class Fee extends StatefulWidget {
  final String id;
  const Fee({super.key, required this.id});

  @override
  State<Fee> createState() => _FeeState();
}

class _FeeState extends State<Fee> {
  List<String> fees = ['-2,50 USD', '-4,49 USD', '-20,75 R\$'];
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
          Text(fees[int.parse(widget.id)],
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500)),
          const Padding(padding: EdgeInsets.only(right: 7.5, left: 7.5)),
          Text('Our free (included)',
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
  const CurrentAt({super.key, required this.id});

  @override
  State<CurrentAt> createState() => _CurrentAtState();
}

class _CurrentAtState extends State<CurrentAt> {
  List<String> city = [
    'Poznan, Poland',
    'Moscow, Russia',
    'Cairo, Egypt',
  ];
  List<String> weight = [
    'Parcel, 20 KG',
    'Parcel, 2 KG',
    'Parcel, 117 KG',
  ];
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
            city[int.parse(widget.id)],
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                wordSpacing: 4,
                letterSpacing: 1.2,
                height: 1.5),
          ),
          Text(weight[int.parse(widget.id)],
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

// HISTORY SECTION
class History extends StatefulWidget {
  final String id;
  const History({super.key, required this.id});

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
          const TitleH(),
          Logs(id: widget.id),
        ],
      ),
    );
  }
}

// HISTORY TITLE
class TitleH extends StatefulWidget {
  const TitleH({super.key});

  @override
  State<TitleH> createState() => _TitleHState();
}

class _TitleHState extends State<TitleH> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('History',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2)),
          Row(
            children: [
              Text('Details', style: TextStyle(color: Colors.deepPurpleAccent)),
              Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.deepPurpleAccent,
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
  const Logs({super.key, required this.id});

  @override
  State<Logs> createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  List<List<List<String>>> info = [
    [
      ['settings', 'In process - Recipient city', 'Poznan, Poland', '12:00AM'],
      [
        'mode_of_travel_sharp',
        'Transit - Sending city',
        'Jakarta, Indonesia',
        '10:00PM'
      ],
      ['upcoming', 'Sent from Sukabumi', 'Sukabumi, Indonesia', '08:00PM']
    ],
    [
      [
        'mode_of_travel_sharp',
        'Transit - Sending city',
        'Rio de Janeiro, Brazil',
        '01:17AM'
      ],
      ['upcoming', 'Sent from São Paulo', 'São Paulo, Brazil', '02:45PM']
    ],
    [
      ['where_to_vote', 'Received - Recipient city', 'Cairo, Egypt', '09:34AM'],
      ['settings', 'In process - Recipient city', 'Cairo, Egypt', '02:01PM'],
      [
        'mode_of_travel_sharp',
        'Transit - Mandatory stop',
        'Paris, France',
        '11:29AM'
      ],
    ]
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < info[int.parse(widget.id)].length; i++)
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
                            color:
                                i == 0 ? Colors.deepPurple : Colors.grey[300],
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            Icons.upcoming,
                            color: i == 0 ? Colors.white : Colors.grey[700],
                            size: 40,
                          ),
                        ),
                        Center(
                          child: Container(
                            color: i == info[int.parse(widget.id)].length - 1
                                ? Colors.white
                                : Colors.grey[300],
                            height: 20,
                            width: 3,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          info[int.parse(widget.id)][i][1],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              wordSpacing: 2,
                              height: 1.5),
                        ),
                        Text(
                          info[int.parse(widget.id)][i][2],
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
                          info[int.parse(widget.id)][i][3],
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
