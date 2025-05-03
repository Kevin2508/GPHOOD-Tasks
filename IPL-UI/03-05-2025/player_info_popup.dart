import 'package:flutter/material.dart';
import 'package:getx_skeleton/main.dart';

class PlayerInfoPopup extends StatefulWidget {
  final Map<String, dynamic> player;
  final Map<String, dynamic>? apiData;
  final String timeLeft;
  final TeamState teamState;
  final Function() onPlayerAdded;
  final Function() onPlayerRemoved;

  const PlayerInfoPopup({
    Key? key,
    required this.player,
    required this.apiData,
    required this.timeLeft,
    required this.teamState,
    required this.onPlayerAdded,
    required this.onPlayerRemoved,
  }) : super(key: key);

  @override
  _PlayerInfoPopupState createState() => _PlayerInfoPopupState();
}

class _PlayerInfoPopupState extends State<PlayerInfoPopup> {
  bool isLoading = true;
  List<Map<String, dynamic>> recentMatches = [];

  @override
  void initState() {
    super.initState();
    fetchPlayerDetails();
  }

  Future<void> fetchPlayerDetails() async {
    try {
      // In a real app, you would fetch the player details from the API using player ID
      // For now, we'll simulate a delay and use sample data
      await Future.delayed(Duration(milliseconds: 300));

      // Check if the player data has recentMatches, otherwise use default
      if (widget.player['recentMatches'] != null && widget.player['recentMatches'] is List) {
        setState(() {
          recentMatches = List<Map<String, dynamic>>.from(
              widget.player['recentMatches'].map((x) => Map<String, dynamic>.from(x)));
          isLoading = false;
        });
      } else {
        // Create default recent matches if not available
        setState(() {
          recentMatches = _getDefaultRecentMatches();
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        recentMatches = _getDefaultRecentMatches();
      });
      print('Error fetching player details: $e');
    }
  }

  List<Map<String, dynamic>> _getDefaultRecentMatches() {
    return [
      {
        'date': 'JUL 05, 2021',
        'opponent': 'MXT',
        'selBy': '20.50%',
        'points': '325',
        'credits': '10.0',
        'color': 'green'
      },
      {
        'date': 'JUL 03, 2021',
        'opponent': 'BLB',
        'selBy': '29.70%',
        'points': '149',
        'credits': '10.0',
        'color': 'red'
      },
      {
        'date': 'MAY 29, 2021',
        'opponent': 'SKC',
        'selBy': '39.50%',
        'points': '336',
        'credits': '10.0',
        'color': 'blue'
      },
      {
        'date': 'MAY 26, 2021',
        'opponent': 'PPD',
        'selBy': '55.50%',
        'points': '395',
        'credits': '9.5',
        'color': 'green'
      },
      {
        'date': 'MAY 23, 2021',
        'opponent': 'WLS',
        'selBy': '77.79%',
        'points': '450',
        'credits': '9.5',
        'color': 'yellow'
      },
      {
        'date': 'MAY 19, 2021',
        'opponent': 'GGS',
        'selBy': '85.90%',
        'points': '777',
        'credits': '9.5',
        'color': 'orange'
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.player['name'] ?? 'N/A';
    final roleParts = (widget.player['role'] ?? 'NA | NA').toString().split(' | ');
    final teamAbbr = roleParts[0]; // e.g., "WLS"
    final playerRole = roleParts.length > 1 ? roleParts[1] : 'N/A';
    final points = widget.player['points']?.toString() ?? 'N/A';
    final credits = widget.player['credits']?.toString() ?? 'N/A';

    final isSelected = widget.teamState.isPlayerSelected(widget.player);
    final canAdd = widget.teamState.canAddPlayer(widget.player);

    return Scaffold(
      backgroundColor: Color(0xff151d24),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : SingleChildScrollView(
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
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.all(8),
                      ),
                      Text(
                        '${widget.timeLeft} left',
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
                        icon: Icon(Icons.close, color: Colors.white),
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.all(8),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Player Info Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              color: Color(0xff151d24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Player Avatar
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[800],
                          border: isSelected
                              ? Border.all(color: Colors.green, width: 2)
                              : null,
                        ),
                        child: widget.player['playerImage'] != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            widget.player['playerImage'],
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        )
                            : Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RichText(
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
                              text: playerRole,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Point',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    points,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Credit',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    credits,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 16),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.red[700]
                          : canAdd
                          ? Colors.green[700]
                          : Colors.grey[700],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      onPressed: isSelected
                          ? () {
                        // Remove player
                        widget.teamState.removePlayer(widget.player);
                        widget.onPlayerRemoved();
                      }
                          : !canAdd
                          ? () {
                        // Show reason why player can't be added
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                widget.teamState.selectedPlayers.length >= 11
                                    ? 'Team is full'
                                    : 'Not enough credits or team limit reached'
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                          : () {
                        // Add player to team
                        widget.teamState.addPlayer(widget.player);
                        widget.onPlayerAdded();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        minimumSize: Size(50, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          isSelected ? 'REMOVE' : 'ADD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Recent Match Status Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              color: Color(0xff0f1419),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent match status',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),

                  if (recentMatches.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Center(
                        child: Text(
                          'No recent match data available',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),

                  // Table Rows with Gradient Backgrounds
                  ...recentMatches.map((match) {
                    Color startColor;
                    switch (match['color']) {
                      case 'red':
                        startColor = Colors.red;
                        break;
                      case 'blue':
                        startColor = Colors.blue;
                        break;
                      case 'yellow':
                        startColor = Colors.yellow;
                        break;
                      case 'orange':
                        startColor = Colors.orange;
                        break;
                      case 'green':
                      default:
                        startColor = Colors.green;
                    }

                    return _buildMatchRow(
                      date: match['date'] ?? 'N/A',
                      opponent: match['opponent'] ?? 'N/A',
                      selBy: match['selBy'] ?? 'N/A',
                      points: match['points'] ?? 'N/A',
                      credits: match['credits'] ?? 'N/A',
                      gradient: LinearGradient(
                        colors: [startColor, Color(0xff151d24), Color(0xff151d24), Color(0xff151d24)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchRow({
    required String date,
    required String opponent,
    required String selBy,
    required String points,
    required String credits,
    required LinearGradient gradient,
  }) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 10,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Divider(
                  color: Color(0xff151d24),
                  thickness: 1,
                  height: 5,
                ),
                SizedBox(height: 5),
                Column(
                  children: [
                    Text(
                      'vs',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      opponent,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SEL BY',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 10,
                  ),
                ),
                Text(
                  selBy,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'POINT',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 10,
                  ),
                ),
                Text(
                  points,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'CREDIT',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 10,
                  ),
                ),
                Text(
                  credits,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}