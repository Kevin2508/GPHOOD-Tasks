import 'package:flutter/material.dart';
import 'package:fantasycricket/home.dart';
import './MyMatchesCompleted.dart';
import './playerinfo.dart';

class Choosecaptain extends StatefulWidget {
  @override
  _ChoosecaptainState createState() => _ChoosecaptainState();
}

class _ChoosecaptainState extends State<Choosecaptain> {
  String selectedRole = 'WK'; // Default to Wicket-Keeper

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
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
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
                            Text(
                              '0h 9m left',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
                                  icon: Icon(Icons.visibility, color: Colors.white),
                                  constraints: BoxConstraints(),
                                  padding: EdgeInsets.all(8),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: teamGradient,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
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
                                          fontSize: 11),
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
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top:18,left: 8.0,right: 8.0),
                                child: Text('5     :     6',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(1),
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
                                          fontSize: 11),
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
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Choose Captain & Vice Captain',style:
                        TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )
                        ),
                        SizedBox(height: 4,),
                        Text('C will get 2x points & VC will get 1.5x points',style:
                        TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        )
                        ),
                      ],
                    ),
                  ),
                  // Filter Buttons
                  // Player List
                  PlayerList(selectedRole: selectedRole),
                  SizedBox(height: 80,)
                ],
              ),
            ),
          ),
          // Floating Save Team Button
          Positioned(
            left: 80.0, // Adjust this value to reduce the width
            right: 80.0, // Adjust this value to reduce the width
            bottom: 16.0,
            child: ElevatedButton(
              onPressed: () {
                // Handle save team action
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayerInfo(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: Size(30, 40), // Button height
                elevation: 5, // Layered effect with shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'SAVE TEAM',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class PlayerList extends StatelessWidget {
  final String selectedRole;

  PlayerList({required this.selectedRole});

  final List<Map<String, dynamic>> playerData = [
    {
      'name': 'R Jackson',
      'role': 'WLS | WK',
      'points': 265,
      'credits': 10.0,
      'selectedBy': '12.0%',
    },
    {
      'name': 'J Caven',
      'role': 'CBR | BAT',
      'points': 265,
      'credits': 9.5,
      'selectedBy': '17.2%',
    },
    {
      'name': 'P Williamson',
      'role': 'CBR | BAT',
      'points': 265,
      'credits': 9.0,
      'selectedBy': '20.2%',
    },
    {
      'name': 'B Cordero',
      'role': 'WLS | DEF',
      'points': 265,
      'credits': 9.0,
      'selectedBy': '17.0%',
    },
    {
      'name': 'J Donald',
      'role': 'CBR | BOWL',
      'points': 265,
      'credits': 8.5,
      'selectedBy': '18.2%',
    },
    {
      'name': 'R Simmons',
      'role': 'WLS | AR',
      'points': 265,
      'credits': 8.0,
      'selectedBy': '19.0%',
    },
    {
      'name': 'K Smith',
      'role': 'CBR | BOWL',
      'points': 265,
      'credits': 8.0,
      'selectedBy': '12.0%',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          // Column Headers
          Container(
            color: Color(0xff0f1419), // Grey background for the header
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'TYPE',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'POINT',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'CAP',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'V CAP',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          // Player Data
          ...playerData.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;
            final roleParts = data['role'].split(' | ');
            final teamAbbr = roleParts[0]; // e.g., "WLS"
            final role = roleParts[1]; // e.g., "WK"
            // Use index to simulate randomness (even indices get "2x" and "1.5x")
            final showMultiplier = index % 2 == 0; // Even indices get "2x" and "1.5x"

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Player Avatar (Placeholder)
                        Container(
                          width: 50,
                          height: 50,
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
                        SizedBox(width: 14),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: teamAbbr,
                                      style: TextStyle(
                                        color: Colors.purple,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' | ',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 11,
                                      ),
                                    ),
                                    TextSpan(
                                      text: role,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: showMultiplier ? Colors.white : Colors.grey[700],
                        ),
                        child: Center(
                          child: Text(
                            showMultiplier ? '2x' : 'C',
                            style: TextStyle(
                              color: Colors.black, // Black text for contrast on white background
                              fontSize: showMultiplier ? 10 : 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: showMultiplier ? Colors.white : Colors.grey[700],
                        ),
                        child: Center(
                          child: Text(
                            showMultiplier ? '1.5x' : 'VC',
                            style: TextStyle(
                              color: Colors.black, // Black text for contrast on white background
                              fontSize: showMultiplier ? 10 : 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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