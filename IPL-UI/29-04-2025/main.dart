import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fantasycricket/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContestScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ContestScreen extends StatefulWidget {
  @override
  _ContestScreenState createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen> {
  String selectedSection = 'Contests';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ground.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(8),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 38.0),
                              child: Text(
                                '0h 9m left',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.notifications, color: Colors.white),
                                  constraints: BoxConstraints(),
                                  padding: EdgeInsets.all(8),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.account_balance_wallet, color: Colors.white),
                                  constraints: BoxConstraints(),
                                  padding: EdgeInsets.all(8),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Teams Container
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff1c5d7c).withOpacity(1),
                      Colors.black.withOpacity(1),
                      Color(0xff2b1b59).withOpacity(0.8),
                    ],
                    stops: [0.2, 0.5, 6.0],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Wolves United',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Image.asset(
                                    'assets/wolves_logo.png',
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'WLS',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('vs',
                            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 16)),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Cobra Guardians',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'CBR',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
                                ),
                                SizedBox(width: 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Image.asset(
                                    'assets/cobra_logo.png',
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Filter Buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                color: Color(0xff0f1419),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildFilterButton('Contests'),
                        SizedBox(width: 8),
                        _buildFilterButton('My Contests (2)'),
                        SizedBox(width: 8),
                        _buildFilterButton('My Team (3)'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Content Section
            Expanded(
              child: selectedSection == 'Contests'
                  ? ListView(
                padding: EdgeInsets.all(8.0),
                children: [
                  ContestCard(
                    title: 'Max Contest',
                    prizePool: '\₹5,00,000',
                    winners: '60% Winners | \₹5,00,000',
                    spots: '10,000 spots',
                    spotsLeft: '3,875 spots left',
                    entryFee: '\₹20',
                  ),
                  ContestCard(
                    title: 'Prize Pool',
                    prizePool: '\₹1,00,000',
                    winners: '50% Winners | \₹10,000',
                    spots: '30,000 spots',
                    spotsLeft: '5,620 spots left',
                    entryFee: '\₹15',
                  ),
                  ContestCard(
                    title: 'Head to Head',
                    prizePool: '\₹500',
                    winners: '50% Winners | \₹500',
                    spots: '2 spots',
                    spotsLeft: '1 spot left',
                    entryFee: '\₹260',
                    isHeadToHead: true,
                  ),
                ],
              )
                  : selectedSection == 'My Contests (2)'
                  ? Center(
                child: Text(
                  'This is My Contests section',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
                  : ListView(
                padding: EdgeInsets.all(8.0),
                children: [
                  PlayerCard(
                    team: 'Samanthateam123 (T1)',
                    points: '5',
                    wickets: '6',
                    player1Name: 'J. Caven',
                    player2Name: 'J. Donald',
                    player1Role: 'BAT',
                    player2Role: 'AR',
                    team1Code: 'WLS',
                    team2Code: 'CBR',
                  ),
                  PlayerCard(
                    team: 'Samanthateam123 (T2)',
                    points: '7',
                    wickets: '4',
                    player1Name: 'J. Caven',
                    player2Name: 'J. Donald',
                    player1Role: 'BAT',
                    player2Role: 'AR',
                    team1Code: 'WLS',
                    team2Code: 'CBR',
                  ),
                ],
              ),
            ),
            // Create Team Button
            if (selectedSection == 'My Team (3)')
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('CREATE TEAM',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text) {
    final isSelected = selectedSection == text;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedSection = text;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: isSelected ? Colors.black : Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: isSelected ? Colors.white : Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      ),
    );
  }
}

class ContestCard extends StatelessWidget {
  final double progress = Random().nextDouble();
  final String title;
  final String prizePool;
  final String winners;
  final String spots;
  final String spotsLeft;
  final String entryFee;
  final bool isHeadToHead;

  ContestCard({
    required this.title,
    required this.prizePool,
    required this.winners,
    required this.spots,
    required this.spotsLeft,
    required this.entryFee,
    this.isHeadToHead = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff151d24),
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Prize Pool', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12)),
                Text('Multiple Entries', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12)),
              ],
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(prizePool, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        winners,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        spots,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(entryFee, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Stack(
                  children: [
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress,
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            Colors.red,
                            Colors.orange,
                            Colors.yellow,
                            Colors.green,
                            Colors.blue,
                            Colors.indigo,
                            Colors.purple,
                          ],
                        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(spotsLeft, style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerCard extends StatelessWidget {
  final String team;
  final String points;
  final String wickets;
  final String player1Name;
  final String player2Name;
  final String player1Role;
  final String player2Role;
  final String team1Code;
  final String team2Code;

  PlayerCard({
    required this.team,
    required this.points,
    required this.wickets,
    required this.player1Name,
    required this.player2Name,
    required this.player1Role,
    required this.player2Role,
    required this.team1Code,
    required this.team2Code,
  });

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/ground.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(team, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 11.5)),
                      SizedBox(height: 18,),
                      Row(
                        children: [
                          Column(

                            children: [
                              Text('$points', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 18)),
                              SizedBox(width: 8),
                              Text(team1Code, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 14)),
                            ],
                          ),
                          SizedBox(width: 18),
                          Column(
                            children: [
                              Text('$wickets', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 18)),
                              Text(team2Code, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 14)),
                            ],
                          ),

                          SizedBox(width: 8),
                          SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 15),

                          SizedBox(
                            height: 100, // enough height to show avatar + label
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 32,
                                  child: Icon(Icons.person, color: Colors.white),
                                ),
                                Positioned(
                                  top: 68, // positioned below the avatar
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[300],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      player1Name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white, // better contrast for yellow
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )



                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          SizedBox(height: 15),
                          SizedBox(
                            height: 100, // enough height to show avatar + label
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 32,
                                  child: Icon(Icons.person, color: Colors.white),
                                ),
                                Positioned(
                                  top: 68, // positioned below the avatar
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[300],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      player2Name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white, // better contrast for yellow
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF2C2C2E),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(text: TextSpan(
                  children: [
                    TextSpan(
                  text: 'WK',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    ),
                  ),
                    TextSpan(
                  text: '(2)',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                    )
                  ]
                ),

            ),
                RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'WK',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: '(2)',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ]
                ),

                ),
                RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'WK',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: '(2)',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ]
                ),

                ),
                RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'WK',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: '(2)',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ]
                ),

                )
              ],
            ),
          )
        ],
      ),

    );
  }
}
