import 'package:flutter/material.dart';
import 'package:fantasycricket/home.dart';
import './MyMatchesCompleted.dart';
import './choosecaptain.dart';
class PlayerSelection extends StatefulWidget {
  @override
  _PlayerSelectionState createState() => _PlayerSelectionState();
}

class _PlayerSelectionState extends State<PlayerSelection> {
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
                                    builder: (context) => Choosecaptain(),
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
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 45.0),
                                  child: Text(
                                    'Max 7 player from a team',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                Text('2     :     1',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                              ],
                            ),
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
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '3/11',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(1),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Selection',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                            ...List.generate(
                              3,
                                  (index) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                            ...List.generate(
                              8,
                                  (index) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            ],
                                ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '8.55',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(1),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Credit',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 12,
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
              // Teams Container

              // Credits Indicator

              // Filter Buttons
              Container(
                color: Colors.black,
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFilterButton('WK', 0),
                        SizedBox(width: 16),
                        _buildFilterButton('BAT', 0),
                        SizedBox(width: 16),
                        _buildFilterButton('AR', 0),
                        SizedBox(width: 16),
                        _buildFilterButton('BOWL', 0),
                      ],
                    ),
                  ),
                ),
              ),
              // Player List
              PlayerList(selectedRole: selectedRole),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(String role, int count) {
    final isSelected = selectedRole == role;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedRole = role;
        });
      },
      child: Text(
        '$role ($count)',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.black : Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(75, 20),
        elevation: 0,
        backgroundColor: isSelected ? Colors.white : Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
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
    // Filter players based on selected role
    final filteredPlayers = playerData.where((player) {
      final role = player['role'].split(' | ')[1];
      return role == selectedRole;
    }).toList();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11.0, vertical: 8.0),
      child: Column(
        children: [
          // Column Headers
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Select 3-5 Defender',
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
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'CREDITS',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.filter_list,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Player Data
          ...filteredPlayers.map((data) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                              Builder(
                                builder: (context) {
                                  final roleParts = data['role'].split(' | ');
                                  final teamAbbr = roleParts[0]; // e.g., "WLS"
                                  // Replace the role with "Sell by 19.20%"
                                  final sellByText = 'Sell by 19.20%';
                                  return RichText(
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
                                          text: '  ',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.6),
                                            fontSize: 11,
                                          ),
                                        ),
                                        TextSpan(
                                          text: sellByText,
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.6),
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
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
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            data['credits'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 4),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 1.5,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: Icon(
                              Icons.add_outlined,
                              color: Colors.green,
                              size: 16,
                            ),
                          ),
                        ],
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