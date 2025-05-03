import 'dart:math';
import 'package:flutter/material.dart';
import 'package:getx_skeleton/app/modules/my_wallet_screen/views/my_wallet_screen_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:getx_skeleton/FantasyCrick/screens/home.dart';
import 'my_matches_completed.dart';

class MatchStats extends StatefulWidget {
  final Map<String, dynamic> matchData;

  const MatchStats({Key? key, required this.matchData}) : super(key: key);

  @override
  _MatchStatsState createState() => _MatchStatsState();
}

class _MatchStatsState extends State<MatchStats> {
  String selectedSection = 'LEADERBOARD'; // Default to LEADERBOARD
  bool isLoading = true;
  List<Map<String, dynamic>> leaderboardData = [];
  List<Map<String, dynamic>> statsData = [];
  List<Map<String, dynamic>> winningsData = [];
  String currentDate = '2025-05-03 07:32:15'; // Using provided date
  String currentUser = 'krishdave-dev'; // Using provided user

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
    fetchMatchStats();
  }

  Future<void> fetchMatchStats() async {
    try {
      // Construct a match ID from team names (or use whatever identifier is relevant)
      final matchId = '${widget.matchData['team1Code']}_vs_${widget.matchData['team2Code']}';

      // Replace with your actual API endpoint
      final response = await http.get(
          Uri.parse('https://betpro.gphood.com/api/match_stats/$matchId')
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          // Populate leaderboard data
          if (data['leaderboard'] != null && data['leaderboard'] is List) {
            leaderboardData = List<Map<String, dynamic>>.from(data['leaderboard']);
          } else {
            leaderboardData = getDefaultLeaderboardData();
          }

          // Populate stats data
          if (data['stats'] != null && data['stats'] is List) {
            statsData = List<Map<String, dynamic>>.from(data['stats']);
          } else {
            statsData = getDefaultStatsData();
          }

          // Populate winnings data
          if (data['winnings'] != null && data['winnings'] is List) {
            winningsData = List<Map<String, dynamic>>.from(data['winnings']);
          } else {
            winningsData = getDefaultWinningsData();
          }

          isLoading = false;
        });
      } else {
        // If API fails, use default data
        setState(() {
          leaderboardData = getDefaultLeaderboardData();
          statsData = getDefaultStatsData();
          winningsData = getDefaultWinningsData();
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching match stats: $e');
      // Use default data on error
      setState(() {
        leaderboardData = getDefaultLeaderboardData();
        statsData = getDefaultStatsData();
        winningsData = getDefaultWinningsData();
        isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> getDefaultLeaderboardData() {
    return [
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
  }

  List<Map<String, dynamic>> getDefaultStatsData() {
    return [
      {
        'name': 'R Jackson',
        'role': 'WLS | WK',
        'runs': 52,
        'balls': 38,
        'sixes': 2,
        'fours': 6,
        'wickets': 0,
        'catches': 2,
      },
      {
        'name': 'J Caven',
        'role': 'CBR | BAT',
        'runs': 78,
        'balls': 45,
        'sixes': 4,
        'fours': 7,
        'wickets': 0,
        'catches': 1,
      },
      {
        'name': 'P Williamson',
        'role': 'CBR | BAT',
        'runs': 35,
        'balls': 28,
        'sixes': 1,
        'fours': 4,
        'wickets': 0,
        'catches': 0,
      },
      {
        'name': 'B Cordero',
        'role': 'CBR | DEF',
        'runs': 12,
        'balls': 10,
        'sixes': 0,
        'fours': 1,
        'wickets': 2,
        'catches': 1,
      },
      {
        'name': 'J Donald',
        'role': 'WLS | BOWL',
        'runs': 2,
        'balls': 5,
        'sixes': 0,
        'fours': 0,
        'wickets': 3,
        'catches': 0,
      },
      {
        'name': 'R Simmons',
        'role': 'WLS | AR',
        'runs': 42,
        'balls': 32,
        'sixes': 1,
        'fours': 5,
        'wickets': 1,
        'catches': 0,
      },
      {
        'name': 'K Smith',
        'role': 'CBR | BOWL',
        'runs': 8,
        'balls': 12,
        'sixes': 0,
        'fours': 1,
        'wickets': 2,
        'catches': 1,
      },
    ];
  }

  List<Map<String, dynamic>> getDefaultWinningsData() {
    return [
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
  }

  @override
  Widget build(BuildContext context) {
    final team1 = widget.matchData['team1'] ?? 'Team 1';
    final team2 = widget.matchData['team2'] ?? 'Team 2';
    final team1Code = widget.matchData['team1Code'] ?? 'T1';
    final team2Code = widget.matchData['team2Code'] ?? 'T2';
    final logo1 = widget.matchData['logo1'] ?? 'assets/images/wolves_logo.png';
    final logo2 = widget.matchData['logo2'] ?? 'assets/images/cobra_logo.png';
    final time = widget.matchData['time'] ?? '90 mins';

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
                    image: AssetImage('assets/images/stadium_bg.jpg'),
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
                                  Navigator.pop(context);
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
                                      // Notification action
                                    },
                                    icon: Icon(Icons.notifications, color: Colors.white),
                                    constraints: BoxConstraints(),
                                    padding: EdgeInsets.all(8),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // Wallet action
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
                              team1,
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
                                    logo1,
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                    errorBuilder: (context, error, stackTrace) => Icon(
                                      Icons.sports_cricket,
                                      color: Colors.white,
                                      size: 40,
                                    ),
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
                                      '1', // Score or other data
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
                        child: Text(time,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              team2,
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
                                      team2Code,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      '3', // Score or other data
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
                                    logo2,
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                    errorBuilder: (context, error, stackTrace) => Icon(
                                      Icons.sports_cricket,
                                      color: Colors.white,
                                      size: 40,
                                    ),
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
              // User and Date Info
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: Color(0xff151c24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'User: $currentUser',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Date: ${currentDate.split(' ')[0]}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
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
              isLoading
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              )
                  : Container(
                child: selectedSection == 'LEADERBOARD'
                    ? Leaderboard(leaderboardData: leaderboardData)
                    : selectedSection == 'WINNINGS'
                    ? WinningsList(winningsData: winningsData)
                    : StatsList(statsData: statsData),
              ),
            ],
          ),
        ),
      ),
      // Add bottom navigation bar consistent with other screens
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Set current index to 1 for "My Matches"
        onTap: (index) {
          if (index == 0) {
            // Home tab
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 1) {
            // My Matches tab (should go back to the matches list)
            Navigator.pop(context);
          } else if (index == 2) {
            // Wallet tab
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyWalletScreenView()),
            );
          }
          // Account tab can be implemented when available
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: "My Matches",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          ),
        ],
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
  final List<Map<String, dynamic>> leaderboardData;

  Leaderboard({required this.leaderboardData});

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
                        SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
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
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold
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

class WinningsList extends StatelessWidget {
  final List<Map<String, dynamic>> winningsData;

  WinningsList({required this.winningsData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          // Contest Card
          ContestCard(
            title: 'Max Contest',
            prizePool: '\₹5,00,000',
            winners: '60% Winners | \₹5,00,000',
            spots: '10,000 spots',
            spotsLeft: '3,875 spots left',
            entryFee: '\₹20',
          ),
          // Column Headers
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                    data['prize'],
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

class StatsList extends StatelessWidget {
  final List<Map<String, dynamic>> statsData;

  StatsList({required this.statsData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        children: [
          // Column Headers
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    'PLAYER',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'RUNS',
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
                    'BALLS',
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
                    '6s',
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
                    '4s',
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
                    'WKTS',
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
          // Stats Data
          ...statsData.map((data) {
            // Use team colors based on team
            final bool isTeam1 = data['role'].toString().contains('WLS');

            return Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: isTeam1
                    ? Color(0xff151c24).withOpacity(0.7)
                    : Color(0xff152526).withOpacity(0.7),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        // Player Avatar (Placeholder)
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[800],
                          ),
                          child: data['playerImage'] != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              data['playerImage'],
                              fit: BoxFit.cover,
                              width: 32,
                              height: 32,
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          )
                              : Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              // Split the role into team abbreviation and role
                              Builder(
                                builder: (context) {
                                  final roleParts = data['role'].split(' | ');
                                  final teamAbbr = roleParts[0]; // e.g., "WLS"
                                  final role = roleParts[1]; // e.g., "WK"
                                  return Text(
                                    '$teamAbbr | $role',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 10,
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
                    flex: 1,
                    child: Text(
                      data['runs'].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      data['balls'].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      data['sixes'].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      data['fours'].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      data['wickets'].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
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