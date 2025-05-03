import 'package:flutter/material.dart';
import 'package:getx_skeleton/FantasyCrick/screens/choose_captain.dart';
import 'package:getx_skeleton/main.dart';
import 'dart:ui'; // Required for BackdropFilter
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'player_info_popup.dart';
import 'team_preview.dart';

// Constants
class AppConstants {
  // Gradients
  static final LinearGradient teamGradient = LinearGradient(
    colors: [
      Color(0xff1c5d7c).withOpacity(1),
      Colors.black.withOpacity(1),
      Color(0xff2b1b59).withOpacity(0.8),
    ],
    stops: [0.2, 0.5, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Placeholder text
  static const String placeholderText = 'N/A';
}

// API Service
class ApiService {
  static const String baseUrl = 'https://betpro.gphood.com/api';

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/index'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return {}; // Return empty map on error
    }
  }
}

// Main Screen
class PlayerSelectionScreen extends StatefulWidget {
  @override
  _PlayerSelectionScreenState createState() => _PlayerSelectionScreenState();
}

class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> {
  String selectedRole = 'WK'; // Default to Wicket-Keeper
  bool isLoading = true;
  Map<String, dynamic>? apiData;
  String timeLeft = AppConstants.placeholderText;
  String team1 = 'Team 1';
  String team2 = 'Team 2';
  String team1Code = 'T1';
  String team2Code = 'T2';
  int team1Count = 0;
  int team2Count = 0;
  int selection = 0;
  double credits = 0.0;
  List<Map<String, dynamic>> playerList = [];
  final ApiService _apiService = ApiService();
  final TeamState _teamState = TeamState();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update local state from team state
    setState(() {
      selection = _teamState.selectedPlayers.length;
      team1Count = _teamState.team1Count;
      team2Count = _teamState.team2Count;
      credits = _teamState.getRemainingCredits();
    });
  }
  void _checkTeamAndProceed(BuildContext context) {
    if (_teamState.isTeamComplete()) {
      // Navigate to choose captain screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChooseCaptain()),
      );
    } else {
      // Show message to complete team
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select 11 players to continue'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  Future<void> fetchData() async {
    try {
      final data = await _apiService.fetchData();

      setState(() {
        apiData = data;
        isLoading = false;

        // Set values from API or use defaults if not available
        timeLeft = data['timeLeft'] ?? AppConstants.placeholderText;
        team1 = data['team1'] ?? 'Team 1';
        team2 = data['team2'] ?? 'Team 2';
        team1Code = data['team1Code'] ?? 'T1';
        team2Code = data['team2Code'] ?? 'T2';

        // These should come from team state
        selection = _teamState.selectedPlayers.length;
        team1Count = _teamState.team1Count;
        team2Count = _teamState.team2Count;
        credits = _teamState.getRemainingCredits();

        // Extract player list from API data
        if (data['players'] != null && data['players'] is List) {
          playerList = List<Map<String, dynamic>>.from(
              data['players'].map((x) => Map<String, dynamic>.from(x)));
        } else {
          // Default player data if not available from API
          playerList = getDefaultPlayers();
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        playerList = getDefaultPlayers();
      });
      print('Error fetching data: $e');
    }
  }

  List<Map<String, dynamic>> getDefaultPlayers() {
    return [
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
        'role': 'WLS | BAT',
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
      // Additional players
      {
        'name': 'M Bruno',
        'role': 'WLS | BAT',
        'points': 245,
        'credits': 8.0,
        'selectedBy': '15.0%',
      },
      {
        'name': 'A Andre',
        'role': 'CBR | AR',
        'points': 230,
        'credits': 8.5,
        'selectedBy': '18.0%',
      },
      {
        'name': 'W Ubon',
        'role': 'WLS | BOWL',
        'points': 220,
        'credits': 7.5,
        'selectedBy': '14.0%',
      },
      {
        'name': 'D Daniel',
        'role': 'CBR | BOWL',
        'points': 210,
        'credits': 7.0,
        'selectedBy': '13.0%',
      },
      {
        'name': 'T Parker',
        'role': 'WLS | WK',
        'points': 240,
        'credits': 8.5,
        'selectedBy': '11.5%',
      },
      {
        'name': 'S Johnson',
        'role': 'CBR | BAT',
        'points': 250,
        'credits': 9.2,
        'selectedBy': '16.8%',
      },
      {
        'name': 'L Mitchell',
        'role': 'WLS | BOWL',
        'points': 235,
        'credits': 8.8,
        'selectedBy': '14.3%',
      },
      {
        'name': 'G Thomas',
        'role': 'CBR | AR',
        'points': 225,
        'credits': 8.6,
        'selectedBy': '15.7%',
      },
      {
        'name': 'H Wilson',
        'role': 'WLS | BAT',
        'points': 260,
        'credits': 9.3,
        'selectedBy': '18.9%',
      },
      {
        'name': 'F Martin',
        'role': 'CBR | BOWL',
        'points': 215,
        'credits': 7.8,
        'selectedBy': '10.2%',
      },
      {
        'name': 'E Davis',
        'role': 'WLS | AR',
        'points': 255,
        'credits': 9.1,
        'selectedBy': '19.5%',
      },
      {
        'name': 'C Harris',
        'role': 'CBR | WK',
        'points': 245,
        'credits': 9.0,
        'selectedBy': '12.7%',
      },
      {
        'name': 'B Thompson',
        'role': 'WLS | BOWL',
        'points': 230,
        'credits': 8.2,
        'selectedBy': '13.4%',
      },
      {
        'name': 'A Jackson',
        'role': 'CBR | BAT',
        'points': 270,
        'credits': 9.7,
        'selectedBy': '21.0%',
      },
    ];
  }

  int _getRoleCount(String role) {
    return playerList.where((player) {
      final playerRole = player['role'].toString().split(' | ').last;
      return playerRole == role;
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : Container(
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
                    image: AssetImage('assets/images/stadium_bg.jpg'),
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
                          onPressed: () {},
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
                                // Navigate to team preview page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => TeamPreview()),
                                ).then((_) {
                                  // Refresh the screen when returning from team preview
                                  setState(() {
                                    selection = _teamState.selectedPlayers.length;
                                    team1Count = _teamState.team1Count;
                                    team2Count = _teamState.team2Count;
                                    credits = _teamState.getRemainingCredits();
                                  });
                                });
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
                  gradient: AppConstants.teamGradient,
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
                                          '$team1Count',
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
                                Text('$team1Count     :     $team2Count',
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
                                          '$team2Count',
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
                                  '$selection/11',
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
                                  selection > 0 ? selection : 0,
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
                                  11 - (selection > 0 ? selection : 0),
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
                                  credits.toStringAsFixed(2),
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

              // Player List
              PlayerList(
                selectedRole: selectedRole,
                playerData: playerList,
                teamState: _teamState,
                onPlayerAdded: () {
                  // Update UI after player added
                  setState(() {
                    selection = _teamState.selectedPlayers.length;
                    team1Count = _teamState.team1Count;
                    team2Count = _teamState.team2Count;
                    credits = _teamState.getRemainingCredits();
                  });
                },
                onPlayerRemoved: () {
                  // Update UI after player removed
                  setState(() {
                    selection = _teamState.selectedPlayers.length;
                    team1Count = _teamState.team1Count;
                    team2Count = _teamState.team2Count;
                    credits = _teamState.getRemainingCredits();
                  });
                },
                onPlayerInfoPress: (player) {
                  _showPlayerInfoDialog(context, player);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _checkTeamAndProceed(context),
        label: Text('CONTINUE'),
        icon: Icon(Icons.arrow_forward),
        backgroundColor: Colors.green,
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

  void _showPlayerInfoDialog(BuildContext context, Map<String, dynamic> player) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              // Blurred background
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              // Full screen player info
              PlayerInfoPopup(
                player: player,
                apiData: apiData,
                timeLeft: timeLeft,
                teamState: _teamState,
                onPlayerAdded: () {
                  // Update UI after player added from info popup
                  setState(() {
                    selection = _teamState.selectedPlayers.length;
                    team1Count = _teamState.team1Count;
                    team2Count = _teamState.team2Count;
                    credits = _teamState.getRemainingCredits();
                  });
                  Navigator.pop(context); // Close dialog after adding
                },
                onPlayerRemoved: () {
                  // Update UI after player removed from info popup
                  setState(() {
                    selection = _teamState.selectedPlayers.length;
                    team1Count = _teamState.team1Count;
                    team2Count = _teamState.team2Count;
                    credits = _teamState.getRemainingCredits();
                  });
                  Navigator.pop(context); // Close dialog after removing
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// Player List Widget
class PlayerList extends StatelessWidget {
  final String selectedRole;
  final List<Map<String, dynamic>> playerData;
  final TeamState teamState;
  final Function() onPlayerAdded;
  final Function() onPlayerRemoved;
  final Function(Map<String, dynamic>) onPlayerInfoPress;

  PlayerList({
    required this.selectedRole,
    required this.playerData,
    required this.teamState,
    required this.onPlayerAdded,
    required this.onPlayerRemoved,
    required this.onPlayerInfoPress,
  });

  @override
  Widget build(BuildContext context) {
    // Filter players based on selected role
    final filteredPlayers = playerData.where((player) {
      final role = player['role'].toString().split(' | ').last;
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
                    'Select 3-5 ${selectedRole == 'BOWL' ? 'Bowlers' : selectedRole == 'BAT' ? 'Batsmen' : selectedRole == 'AR' ? 'All-Rounders' : 'Wicket-Keepers'}',
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

          // If no players match the filter
          if (filteredPlayers.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'No ${selectedRole} players available',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

          // Player Data
          ...filteredPlayers.map((data) {
            final isSelected = teamState.isPlayerSelected(data);
            final canAdd = teamState.canAddPlayer(data);

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
                            border: isSelected
                                ? Border.all(color: Colors.green, width: 2)
                                : null,
                          ),
                          child: data['playerImage'] != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              data['playerImage'],
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
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
                                data['name'] ?? AppConstants.placeholderText,
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
                                  final roleParts = (data['role'] ?? 'NA | NA').toString().split(' | ');
                                  final teamAbbr = roleParts[0]; // e.g., "WLS"
                                  // Use 'selectedBy' from API data if available
                                  final sellByText = 'Sel by ${data['selectedBy'] ?? AppConstants.placeholderText}';
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
                      data['points']?.toString() ?? AppConstants.placeholderText,
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
                            data['credits']?.toString() ?? AppConstants.placeholderText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 4),
                          GestureDetector(
                            onTap: isSelected
                                ? () {
                              // Show confirmation dialog to remove player
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Color(0xff151d24),
                                  title: Text(
                                      "Remove Player",
                                      style: TextStyle(color: Colors.white)
                                  ),
                                  content: Text(
                                    "Do you want to remove ${data['name']} from your team?",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Cancel", style: TextStyle(color: Colors.white)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Remove player from team
                                        int playerIndex = teamState.selectedPlayers.indexWhere(
                                                (p) => p['name'] == data['name']
                                        );

                                        if (playerIndex != -1) {
                                          // Adjust team counts
                                          final teamCode = data['role'].toString().split(' | ')[0];
                                          if (teamCode == 'WLS') {
                                            teamState.team1Count--;
                                          } else if (teamCode == 'CBR') {
                                            teamState.team2Count--;
                                          }

                                          // Adjust credits
                                          teamState.usedCredits -= (data['credits'] ?? 0.0);

                                          // Remove from selected players
                                          teamState.selectedPlayers.removeAt(playerIndex);

                                          // Clear captain/vice-captain if needed
                                          if (teamState.captain != null &&
                                              teamState.captain!['name'] == data['name']) {
                                            teamState.captain = null;
                                          }

                                          if (teamState.viceCaptain != null &&
                                              teamState.viceCaptain!['name'] == data['name']) {
                                            teamState.viceCaptain = null;
                                          }

                                          onPlayerRemoved();
                                        }

                                        Navigator.pop(context);
                                      },
                                      child: Text("Remove", style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                            }
                                : () {
                              // Show player info popup when clicking the + button
                              onPlayerInfoPress(data);
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.red
                                      : canAdd
                                      ? Colors.green
                                      : Colors.red,
                                  width: 1.5,
                                ),
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              child: Center(
                                child: Icon(
                                  isSelected
                                      ? Icons.remove
                                      : Icons.add,
                                  color: isSelected
                                      ? Colors.red
                                      : canAdd
                                      ? Colors.green
                                      : Colors.red,
                                  size: 16,
                                ),
                              ),
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