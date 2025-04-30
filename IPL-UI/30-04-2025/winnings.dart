import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fantasycricket/home.dart';
import './MyMatchesCompleted.dart';
import './matchstats.dart';

class Winnings extends StatefulWidget {
  @override
  _WinningsState createState() => _WinningsState();
}

class _WinningsState extends State<Winnings> {
  String selectedSection = 'WINNINGS';

  final teamGradient = LinearGradient(
    colors: [
      Color(0xff1c5d7c).withOpacity(1),
      Colors.black.withOpacity(1),
      Color(0xff2b1b59).withOpacity(0.8),
    ],
    stops: [0.2, 0.5, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
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
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  );
                                },
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
                                          builder: (context) => MatchStats(),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.notifications, color: Colors.white),
                                    constraints: BoxConstraints(),
                                    padding: EdgeInsets.all(8),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Mymatchescompleted(),
                                        ),
                                      );
                                    },
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
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: teamGradient,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'WOLVES UNITED',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'VS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'COBRA GUARDIANS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Content Section (ContestCard)
              Container(
                child: Column(
                  children: [
                    ContestCard(
                      title: 'Max Contest',
                      prizePool: '\₹5,00,000',
                      winners: '60% Winners | \₹5,00,000',
                      spots: '10,000 spots',
                      spotsLeft: '3,875 spots left',
                      entryFee: '\₹20',
                    ),
                  ],
                ),
              ),
              // Filter Buttons
              Container(
                color: Color(0xff0f1419),
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFilterButton('WINNINGS'),
                        SizedBox(width: 38),
                        _buildFilterButton('LEADERBOARD'),
                      ],
                    ),
                  ),
                ),
              ),
              // Winnings List or Leaderboard
              Container(
                child: selectedSection == 'WINNINGS'
                    ? WinningsList()
                    : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Leaderboard section coming soon',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
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
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.black : Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(140, 30),
        elevation: 0,
        backgroundColor: isSelected ? Colors.white : Color(0xff151d24),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

class WinningsList extends StatelessWidget {
  final List<Map<String, String>> winningsData = [
    {'rank': '#1', 'prize': '\$50,000'},
    {'rank': '#2', 'prize': '\$25,000'},
    {'rank': '#3', 'prize': '\$15,000'},
    {'rank': '#4', 'prize': '\$10,000'},
    {'rank': '#5', 'prize': '\$5,000'},
    {'rank': '#6', 'prize': '\$2,500'},
    {'rank': '#7', 'prize': '\$1,500'},
    {'rank': '#8', 'prize': '\$1,000'},
    {'rank': '#9', 'prize': '\$500'},
    {'rank': '#10', 'prize': '\$250'},
    {'rank': '#11 - 15', 'prize': '\$100'},
    {'rank': '#16 - 25', 'prize': '\$50'},
    {'rank': '#26 - 50', 'prize': '\$45'},
    {'rank': '#51 - 100', 'prize': '\$40'},
    {'rank': '#101 - 200', 'prize': '\$35'},
    {'rank': '#201 - 500', 'prize': '\$30'},
    {'rank': '#501 - 1000', 'prize': '\$25'},
    {'rank': '#1001 - 2000', 'prize': '\$20'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          // Column Headers
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'RANK',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'WINNINGS',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Winnings Data
          ...winningsData.map((data) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${data['rank']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    data['prize']!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
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
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Prize Pool',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.6), fontSize: 12)),
                Text('Multiple Entries',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.6), fontSize: 12)),
              ],
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(prizePool,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
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
                    SizedBox(width: 6),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(entryFee,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: Size(5, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
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
                        ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
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
                Text(spotsLeft,
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}