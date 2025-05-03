import 'package:flutter/material.dart';
import 'package:getx_skeleton/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'team_preview.dart';

class ChooseCaptain extends StatefulWidget {
  @override
  _ChooseCaptainState createState() => _ChooseCaptainState();
}

class _ChooseCaptainState extends State<ChooseCaptain> {
  String selectedRole = 'WK'; // Default to Wicket-Keeper
  bool isLoading = true;
  Map<String, dynamic>? apiData;
  String timeLeft = 'N/A';
  final TeamState _teamState = TeamState();

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
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://betpro.gphood.com/api/index'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          apiData = data;
          isLoading = false;

          // Set values from API or use defaults if not available
          timeLeft = data['timeLeft'] ?? 'N/A';
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

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
                        image: AssetImage('assets/images/staduim_bg.jpg'),
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
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(8),
                            ),
                            Text(
                              '$timeLeft left',
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
                                    // Navigate to team preview
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => TeamPreview()),
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
                                            'assets/images/wolves_logo.png',
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
                                child: Text('${_teamState.team1Count}     :     ${_teamState.team2Count}',
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
                                            'assets/images/cobra_logo.png',
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
                        Text(
                            'Choose Captain & Vice Captain',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        SizedBox(height: 4,),
                        Text(
                            'C will get 2x points & VC will get 1.5x points',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ],
                    ),
                  ),
                  // Player List
                  CaptainPlayerList(
                    teamState: _teamState,
                    onCaptainSelected: (player) {
                      setState(() {
                        _teamState.setCaptain(player);
                      });
                    },
                    onViceCaptainSelected: (player) {
                      setState(() {
                        _teamState.setViceCaptain(player);
                      });
                    },
                  ),
                  SizedBox(height: 80,)
                ],
              ),
            ),
          ),
          // Floating Save Team Button
          Positioned(
            left: 80.0,
            right: 80.0,
            bottom: 16.0,
            child: ElevatedButton(
              onPressed: _teamState.areCaptainsSelected() ? () {
                // Handle save team action
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Team saved successfully!'),
                    duration: Duration(seconds: 2),
                  ),
                );

                // Navigate to team preview
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TeamPreview()),
                );
              } : null, // Disable if captains not selected
              style: ElevatedButton.styleFrom(
                backgroundColor: _teamState.areCaptainsSelected() ? Colors.green : Colors.grey,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.withOpacity(0.5),
                disabledForegroundColor: Colors.white.withOpacity(0.7),
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

class CaptainPlayerList extends StatelessWidget {
  final TeamState teamState;
  final Function(Map<String, dynamic>) onCaptainSelected;
  final Function(Map<String, dynamic>) onViceCaptainSelected;

  CaptainPlayerList({
    required this.teamState,
    required this.onCaptainSelected,
    required this.onViceCaptainSelected,
  });

  @override
  Widget build(BuildContext context) {
    final players = teamState.selectedPlayers;

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
          ...players.map((player) {
            final roleParts = player['role'].toString().split(' | ');
            final teamAbbr = roleParts[0]; // e.g., "WLS"
            final role = roleParts.length > 1 ? roleParts[1] : 'N/A'; // e.g., "WK"
            final isCaptain = player == teamState.captain;
            final isViceCaptain = player == teamState.viceCaptain;

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
                            border: isCaptain || isViceCaptain
                                ? Border.all(
                              color: isCaptain ? Colors.green : Colors.blue,
                              width: 2,
                            )
                                : null,
                          ),
                          child: player['playerImage'] != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              player['playerImage'],
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          )
                              : Icon(
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
                                player['name'] ?? 'N/A',
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
                      player['points']?.toString() ?? 'N/A',
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
                      child: GestureDetector(
                        onTap: () => onCaptainSelected(player),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCaptain ? Colors.white : Colors.grey[700],
                          ),
                          child: Center(
                            child: Text(
                              isCaptain ? '2x' : 'C',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: isCaptain ? 10 : 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: GestureDetector(
                        onTap: () => onViceCaptainSelected(player),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isViceCaptain ? Colors.white : Colors.grey[700],
                          ),
                          child: Center(
                            child: Text(
                              isViceCaptain ? '1.5x' : 'VC',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: isViceCaptain ? 10 : 12,
                                fontWeight: FontWeight.bold,
                              ),
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