import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fantasycricket/home.dart';
import './MyMatchesCompleted.dart';
import './create_new_team.dart';
class MatchStats extends StatefulWidget {
  @override
  _MatchStatsState createState() => _MatchStatsState();
}

class _MatchStatsState extends State<MatchStats> {
  String selectedSection = 'LEADERBOARD'; // Default to LEADERBOARD

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
                                  'Match Completed',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
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
                                          builder: (context) => PlayerSelection(),
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
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 12),
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
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'WLS',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('90 mins',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Cobra Guardians',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 12),
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'CBR',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      '3',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12),
                                    ),
                                  ],
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
              // Filter Buttons
              Container(
                color: Color(0xff0f1419),
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFilterButton('WINNINGS'),
                        SizedBox(width: 8),
                        _buildFilterButton('LEADERBOARD'),
                        SizedBox(width: 8),
                        _buildFilterButton('STATS'),
                      ],
                    ),
                  ),
                ),
              ),
              // Content Section
              Container(
                child: selectedSection == 'LEADERBOARD'
                    ? Leaderboard()
                    : selectedSection == 'WINNINGS'
                    ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Winnings section coming soon',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Stats section coming soon',
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
        minimumSize: Size(100, 30),
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

class Leaderboard extends StatelessWidget {
  final Random _random = Random();
  final List<Map<String, dynamic>> leaderboardData = [
    {
      'name': 'R Jackson',
      'role': 'WLS | WK',
      'points': 123.0,
      'selectedBy': '55.9%',
    },
    {
      'name': 'J Caven',
      'role': 'CBR | BAT',
      'points': 98.0,
      'selectedBy': '41.0%',
    },
    {
      'name': 'P Williamson',
      'role': 'CBR | BAT',
      'points': 91.0,
      'selectedBy': '23.5%',
    },
    {
      'name': 'B Cordero',
      'role': 'CBR | DEF',
      'points': 88.0,
      'selectedBy': '11.2%',
    },
    {
      'name': 'J Donald',
      'role': 'WLS | BOWL',
      'points': 58.0,
      'selectedBy': '0.5%',
    },
    {
      'name': 'R Simmons',
      'role': 'WLS | AR',
      'points': 49.5,
      'selectedBy': '90.1%',
    },
    {
      'name': 'K Smith',
      'role': 'CBR | BOWL',
      'points': 33.0,
      'selectedBy': '50.0%',
    },
    {
      'name': 'W Ubanto',
      'role': 'WLS | AR',
      'points': 15.0,
      'selectedBy': '33.3%',
    },
    {
      'name': 'P Johnson',
      'role': 'CBR | BOWL',
      'points': 0.0,
      'selectedBy': '87.5%',
    },
    {
      'name': 'D Daniel',
      'role': 'WLS | AR',
      'points': -5.0,
      'selectedBy': '10.5%',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final leaderboardGradient = LinearGradient(
      colors: [
        Color(0xff151c24).withOpacity(1),
        Color(0xff152625).withOpacity(01),
        Color(0xff154527).withOpacity(1),
      ],
      stops: [0.2, 0.5, 1.0],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return Container(
      child: Column(
        children: [
          // Column Headers
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'PLAYER',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'POINTS',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'SELL BY',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          // Leaderboard Data
          ...leaderboardData.map((data) {
            // Randomly decide if this row should have a gradient background
            final bool hasGradient = _random.nextBool();

            return Container(
              padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
              decoration: hasGradient
                  ? BoxDecoration(
                gradient: leaderboardGradient,
                borderRadius: BorderRadius.circular(0),
              )
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        // Player Avatar (Placeholder)
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[800],
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['name'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Split the role into team abbreviation and role
                            Builder(
                              builder: (context) {
                                final roleParts = data['role'].split(' | ');
                                final teamAbbr = roleParts[0]; // e.g., "WLS"
                                final role = roleParts[1]; // e.g., "WK"
                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: teamAbbr,
                                        style: TextStyle(
                                          color: Colors.purple,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' | ',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.6),
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: role,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.6),
                                          fontSize: 12,fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      data['points'].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      data['selectedBy'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
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