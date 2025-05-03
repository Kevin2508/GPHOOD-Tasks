import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getx_skeleton/FantasyCrick/screens/create_new_team.dart';
import 'package:getx_skeleton/FantasyCrick/screens/player_selection_screen.dart';
import 'package:http/http.dart' as http;

class ContestScreen extends StatefulWidget {
  @override
  _ContestScreenState createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen> {
  String selectedSection = 'Contests'; // Default section
  Map<String, dynamic>? apiData; // Holds data fetched from the API
  bool isLoading = true; // Tracks the loading state
  bool isError = false; // Tracks the error state

  static const String placeholderText = 'N/A'; // Placeholder for null values

  // Gradient for the team container
  final LinearGradient teamGradient = LinearGradient(
    colors: [
      Color(0xff1c5d7c).withOpacity(1),
      Colors.black.withOpacity(1),
      Color(0xff2b1b59).withOpacity(0.8),
    ],
    stops: [0.2, 0.5, 6.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the screen initializes
  }

  // Fetch data from the API
  Future<void> fetchData() async {
    final String apiUrl = 'https://example.com/api/contest-data'; // Replace with your API URL

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          apiData = json.decode(response.body); // Parse JSON response
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      setState(() {
        isError = true;
        isLoading = false;
        apiData = {}; // Set apiData to an empty map to use null values
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: isLoading
            ? const Center(child: CircularProgressIndicator()) // Show loading spinner
            : Column(
          children: [
            // Header Section
            _buildHeader(),
            // Teams Container
            _buildTeamsContainer(),
            // Filter Buttons
            _buildFilterButtons(),
            // Content Section
            Expanded(
              child: _buildContentSection(),
            ),
            // Create Team Button
            if (selectedSection == 'My Team')
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayerSelectionScreen()));
                  },
                  child: Text(
                    'CREATE TEAM',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 12.0),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final String timeLeft = apiData?['timeLeft'] ?? placeholderText;
    return Container(
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
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.account_balance_wallet, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamsContainer() {
    final String team1 = apiData?['team1'] ?? 'Team 1';
    final String team2 = apiData?['team2'] ?? 'Team 2';
    final String team1Code = apiData?['team1Code'] ?? 'T1';
    final String team2Code = apiData?['team2Code'] ?? 'T2';
    final String? team1Logo = apiData?['team1Logo'];
    final String? team2Logo = apiData?['team2Logo'];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: teamGradient),
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
                        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      team1Logo != null
                          ? Image.network(
                        team1Logo,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      )
                          : Icon(Icons.image, color: Colors.white, size: 60),
                      SizedBox(width: 4),
                      Text(
                        team1Code,
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
                    team2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        team2Code,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(width: 4),
                      team2Logo != null
                          ? Image.network(
                        team2Logo,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      )
                          : Icon(Icons.image, color: Colors.white, size: 60),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        color: Color(0xff0f1419),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
          child: Row(
            children: [
              _buildFilterButton('Contests'),
              SizedBox(width: 8),
              _buildFilterButton('My Contests'),
              SizedBox(width: 8),
              _buildFilterButton('My Team'),
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
          color: isSelected ? Colors.black : Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.white : Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      ),
    );
  }

  Widget _buildContentSection() {
    if (selectedSection == 'Contests') {
      final List<dynamic>? contests = apiData?['contests'];

      if (contests == null || contests.isEmpty) {
        return Center(
          child: Text(
            'No Contests Available',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: contests.length,
        itemBuilder: (context, index) {
          final contest = contests[index];
          return ContestCard(
            title: contest['title'] ?? placeholderText,
            prizePool: contest['prizePool'] ?? placeholderText,
            winners: contest['winners'] ?? placeholderText,
            spots: contest['spots'] ?? placeholderText,
            spotsLeft: contest['spotsLeft'] ?? placeholderText,
            entryFee: contest['entryFee'] ?? placeholderText,
          );
        },
      );
    } else if (selectedSection == 'My Contests (2)') {
      return Center(
        child: Text(
          'This is My Contests section',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    } else {
      return Center(
        child: Text(
          'This is My Team section',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }
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

  ContestCard({
    required this.title,
    required this.prizePool,
    required this.winners,
    required this.spots,
    required this.spotsLeft,
    required this.entryFee,
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
                    SizedBox(
                      width: 6,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(entryFee,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: Size(5, 30)),
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