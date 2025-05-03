import 'package:flutter/material.dart';
import 'package:getx_skeleton/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './choose_captain.dart';
class TeamPreview extends StatefulWidget {
  @override
  _TeamPreviewState createState() => _TeamPreviewState();
}

class _TeamPreviewState extends State<TeamPreview> {
  String selectedRole = 'WK';
  bool isLoading = true;
  Map<String, dynamic>? apiData;
  String timeLeft = 'N/A';
  String team1 = 'Wolves United';
  String team2 = 'Cobra Guardians';
  String team1Code = 'WLS';
  String team2Code = 'CBR';

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
          team1 = data['team1'] ?? 'Wolves United';
          team2 = data['team2'] ?? 'Cobra Guardians';
          team1Code = data['team1Code'] ?? 'WLS';
          team2Code = data['team2Code'] ?? 'CBR';
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

  // Get the count of players by role
  int _getRoleCount(String role) {
    return _teamState.selectedPlayers.where((player) {
      final playerRole = player['role'].toString().split(' | ').last;
      return playerRole == role;
    }).length;
  }

  // Build player arrangement based on roles
  Widget _buildPlayerArrangement() {

    // If no players are selected yet, show default arrangement with placeholders
    if (_teamState.selectedPlayers.isEmpty) {

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Row 1: 1 Player
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPlayerWidget(
                name: 'J Caven',
                credit: '9.0',
                isCaptain: true,
                isViceCaptain: false,

              ),
            ],
          ),
          // Row 2: 3 Players
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPlayerWidget(
                name: 'P Willia...',
                credit: '9.0',
                isCaptain: true,
                isViceCaptain: false,
              ),
              _buildPlayerWidget(
                name: 'B Corde...',
                credit: '9.0',
                isCaptain: false,
                isViceCaptain: true,
              ),

              _buildPlayerWidget(
                name: 'R Simm...',
                credit: '9.0',
                isCaptain: false,
                isViceCaptain: false,
              ),
            ],
          ),
          // Row 3: 4 Players
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPlayerWidget(
                name: 'K Smith',
                credit: '8.0',
                isCaptain: false,
                isViceCaptain: false,
              ),
              _buildPlayerWidget(
                name: 'M Bruno',
                credit: '9.0',
                isCaptain: false,
                isViceCaptain: false,
              ),
              _buildPlayerWidget(
                name: 'A Andre',
                credit: '9.0',
                isCaptain: false,
                isViceCaptain: false,
              ),
              _buildPlayerWidget(
                name: 'W Ubon',
                credit: '9.0',
                isCaptain: false,
                isViceCaptain: false,
              ),
            ],
          ),
          // Row 4: 3 Players
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPlayerWidget(
                name: 'P Johns...',
                credit: '9.0',
                isCaptain: false,
                isViceCaptain: false,
              ),
              _buildPlayerWidget(
                name: 'D Dan...',
                credit: '9.0',
                isCaptain: false,
                isViceCaptain: false,
              ),
              _buildPlayerWidget(
                name: 'L Opero...',
                credit: '9.0',
                isCaptain: false,
                isViceCaptain: false,
              ),
            ],
          ),
        ],
      );
    }

    // Group selected players by role
    List<Map<String, dynamic>> wkPlayers = [];
    List<Map<String, dynamic>> batPlayers = [];
    List<Map<String, dynamic>> arPlayers = [];
    List<Map<String, dynamic>> bowlPlayers = [];

    for (var player in _teamState.selectedPlayers) {
      final roleParts = player['role'].toString().split(' | ');
      final playerRole = roleParts.length > 1 ? roleParts[1] : '';

      if (playerRole == 'WK') {
        wkPlayers.add(player);
      } else if (playerRole == 'BAT') {
        batPlayers.add(player);
      } else if (playerRole == 'AR') {
        arPlayers.add(player);
      } else if (playerRole == 'BOWL') {
        bowlPlayers.add(player);
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Row 1: Wicket-keepers
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: wkPlayers.isEmpty
              ? [_buildEmptyPlayerWidget('WK')]
              : wkPlayers.map((player) => _buildPlayerWidget(
            name: _shortenName(player['name'] ?? 'N/A'),
            credit: player['credits']?.toString() ?? 'N/A',
            isCaptain: player == _teamState.captain,
            isViceCaptain: player == _teamState.viceCaptain,
            playerImage: player['playerImage'],

          )).toList(),
        ),
        // Row 2: Batsmen
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: batPlayers.isEmpty
              ? [_buildEmptyPlayerWidget('BAT')]
              : batPlayers.map((player) => _buildPlayerWidget(
            name: _shortenName(player['name'] ?? 'N/A'),
            credit: player['credits']?.toString() ?? 'N/A',
            isCaptain: player == _teamState.captain,
            isViceCaptain: player == _teamState.viceCaptain,
            playerImage: player['playerImage'],
          )).toList(),
        ),
        // Row 3: All-rounders
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: arPlayers.isEmpty
              ? [_buildEmptyPlayerWidget('AR')]
              : arPlayers.map((player) => _buildPlayerWidget(
            name: _shortenName(player['name'] ?? 'N/A'),
            credit: player['credits']?.toString() ?? 'N/A',
            isCaptain: player == _teamState.captain,
            isViceCaptain: player == _teamState.viceCaptain,
            playerImage: player['playerImage'],
          )).toList(),
        ),
        // Row 4: Bowlers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: bowlPlayers.isEmpty
              ? [_buildEmptyPlayerWidget('BOWL')]
              : bowlPlayers.map((player) => _buildPlayerWidget(
            name: _shortenName(player['name'] ?? 'N/A'),
            credit: player['credits']?.toString() ?? 'N/A',
            isCaptain: player == _teamState.captain,
            isViceCaptain: player == _teamState.viceCaptain,
            playerImage: player['playerImage'],
          )).toList(),
        ),
      ],
    );
  }

  String _shortenName(String name) {
    if (name.length > 8) {
      return name.substring(0, 7) + '...';
    }
    return name;
  }

  Widget _buildEmptyPlayerWidget(String role) {
    return _buildPlayerWidget(
      name: 'Add $role',
      credit: '0.0',
      isCaptain: false,
      isViceCaptain: false,
      isEmpty: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Green background from screenshot
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/stadium_bg.jpg'), // Replace with your image path
            fit: BoxFit.cover, // Ensures the image covers the entire screen
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white),
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
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.edit, color: Colors.white),
                      padding: EdgeInsets.all(8),
                    ),
                  ],
                ),
              ),
              // Player Arrangement
              Expanded(
                child: _buildPlayerArrangement(),
              ),
              SizedBox(height: 8,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: teamGradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:8,vertical: 16.0),
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
                                  team1,
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
                                      child: apiData?['team1Logo'] != null
                                          ? Image.network(
                                        apiData!['team1Logo'],
                                        fit: BoxFit.cover,
                                        width: 60,
                                        height: 60,
                                        errorBuilder: (context, error, stackTrace) => Image.asset(
                                          'assets/images/wolves_logo.png',
                                          fit: BoxFit.cover,
                                          width: 60,
                                          height: 60,
                                        ),
                                      )
                                          : Image.asset(
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
                                          team1Code,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '${_teamState.team1Count}',
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
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                                Text('${_teamState.team1Count}     :     ${_teamState.team2Count}',
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
                                  team2,
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
                                          team2Code,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '${_teamState.team2Count}',
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
                                      child: apiData?['team2Logo'] != null
                                          ? Image.network(
                                        apiData!['team2Logo'],
                                        fit: BoxFit.cover,
                                        width: 60,
                                        height: 60,
                                        errorBuilder: (context, error, stackTrace) => Image.asset(
                                          'assets/images/cobra_logo.png',
                                          fit: BoxFit.cover,
                                          width: 60,
                                          height: 60,
                                        ),
                                      )
                                          : Image.asset(
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
                                  '${_teamState.selectedPlayers.length}/11',
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
                                  _teamState.selectedPlayers.length,
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
                                  11 - _teamState.selectedPlayers.length,
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
                                  _teamState.getRemainingCredits().toStringAsFixed(1),
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
                        _buildFilterButton('WK', _getRoleCount('WK')),
                        SizedBox(width: 16),
                        _buildFilterButton('BAT', _getRoleCount('BAT')),
                        SizedBox(width: 16),
                        _buildFilterButton('AR', _getRoleCount('AR')),
                        SizedBox(width: 16),
                        _buildFilterButton('BOWL', _getRoleCount('BOWL')),
                      ],
                    ),
                  ),
                ),
              ),
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
          color: isSelected ? Colors.white : Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(75, 20),
        elevation: 0,
        backgroundColor: isSelected ? Colors.black : Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  // Inside the _buildPlayerWidget method, update to show captain and vice-captain status:

  Widget _buildPlayerWidget({
    required String name,
    required String credit,
    required bool isCaptain,
    required bool isViceCaptain,
    String? playerImage,
    bool isEmpty = false,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isEmpty ? Colors.grey.withOpacity(0.5) : Colors.yellow,
            border: Border.all(
              color: isCaptain ? Colors.green : isViceCaptain ? Colors.blue : Colors.black,
              width: isCaptain || isViceCaptain ? 3 : 2,
            ),
          ),
          child: playerImage != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              playerImage,
              fit: BoxFit.cover,
              width: 60,
              height: 60,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.person,
                color: Colors.black,
                size: 40,
              ),
            ),
          )
              : Icon(
            Icons.person,
            color: Colors.black,
            size: 40,
          ),
        ),
        SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: isEmpty ? Colors.grey.withOpacity(0.5) : Colors.blue,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Text(
          credit,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
        if (isCaptain)
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Center(
              child: Text(
                'C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        if (isViceCaptain)
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Center(
              child: Text(
                'VC',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

// Update _buildPlayerArrangement to check for captains:
// Inside the _buildPlayerArrangement method when building player widgets:


}