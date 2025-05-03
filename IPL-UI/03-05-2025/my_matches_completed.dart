import 'package:flutter/material.dart';
import 'package:getx_skeleton/FantasyCrick/screens/home.dart';
import 'package:getx_skeleton/FantasyCrick/screens/match_stats.dart';
import 'package:getx_skeleton/FantasyCrick/screens/wallet_screen_adapter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Mymatchescompleted extends StatefulWidget {
  const Mymatchescompleted({super.key});

  @override
  State<Mymatchescompleted> createState() => _MyMatchesCompletedState();
}

class _MyMatchesCompletedState extends State<Mymatchescompleted> {
  final PageController _pageController = PageController();
  String selectedSection = 'COMPLETED'; // Default to COMPLETED to match your UI
  bool isLoading = true;
  List<Map<String, dynamic>> matchesList = [];

  @override
  void initState() {
    super.initState();
    fetchMatches();
  }

  Future<void> fetchMatches() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Replace with your actual API endpoint
      final response = await http.get(Uri.parse('https://betpro.gphood.com/api/matches?status=${selectedSection.toLowerCase()}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['matches'] != null && data['matches'] is List) {
          setState(() {
            matchesList = List<Map<String, dynamic>>.from(data['matches']);
            isLoading = false;
          });
        } else {
          setState(() {
            matchesList = getDefaultMatches();
            isLoading = false;
          });
        }
      } else {
        // If API fails, use default data
        setState(() {
          matchesList = getDefaultMatches();
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching matches: $e');
      // Use default data on error
      setState(() {
        matchesList = getDefaultMatches();
        isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> getDefaultMatches() {
    // Return default data based on the selected section
    if (selectedSection == 'UPCOMING') {
      return [
        {
          'team1': 'WOLVES UNITED',
          'team2': 'GREAT GORILLAS',
          'league': 'Mexican League',
          'time': '1h 30m',
          'maxPrize': '5 Million',
          'team1Code': 'WLS',
          'team2Code': 'GGS',
          'logo1': 'assets/images/wolves_logo.png',
          'logo2': 'assets/images/wolves_logo.png',
        },
        {
          'team1': 'COBRA KINGS',
          'team2': 'TIGER WARRIORS',
          'league': 'European Tour',
          'time': '3h 15m',
          'maxPrize': '2 Million',
          'team1Code': 'CBK',
          'team2Code': 'TGW',
          'logo1': 'assets/images/wolves_logo.png',
          'logo2': 'assets/images/wolves_logo.png',
        },
        {
          'team1': 'FALCON FLYERS',
          'team2': 'DRAGON MASTERS',
          'league': 'World Tour',
          'time': '6h 45m',
          'maxPrize': '10 Million',
          'team1Code': 'FAL',
          'team2Code': 'DRM',
          'logo1': 'assets/images/wolves_logo.png',
          'logo2': 'assets/images/wolves_logo.png',
        },
      ];
    } else if (selectedSection == 'LIVE') {
      return [
        {
          'team1': 'LION KINGS',
          'team2': 'EAGLE HUNTERS',
          'league': 'Asian Cup',
          'time': 'LIVE',
          'maxPrize': '7 Million',
          'team1Code': 'LNK',
          'team2Code': 'EGH',
          'logo1': 'assets/images/wolves_logo.png',
          'logo2': 'assets/images/wolves_logo.png',
        },
        {
          'team1': 'RHINO FORCE',
          'team2': 'PANTHER PROWL',
          'league': 'National League',
          'time': 'LIVE',
          'maxPrize': '3 Million',
          'team1Code': 'RHF',
          'team2Code': 'PNP',
          'logo1': 'assets/images/wolves_logo.png',
          'logo2': 'assets/images/wolves_logo.png',
        },
      ];
    } else { // COMPLETED
      return [
        {
          'team1': 'WOLVES UNITED',
          'team2': 'GREAT GORILLAS',
          'league': 'Mexican League',
          'time': 'Completed',
          'maxPrize': '5 Million',
          'team1Code': 'WLS',
          'team2Code': 'GGS',
          'logo1': 'assets/images/wolves_logo.png',
          'logo2': 'assets/images/wolves_logo.png',
        },
        {
          'team1': 'SHARK ATTACK',
          'team2': 'BEAR WARRIORS',
          'league': 'Continental Cup',
          'time': 'Completed',
          'maxPrize': '8 Million',
          'team1Code': 'SHA',
          'team2Code': 'BEW',
          'logo1': 'assets/images/wolves_logo.png',
          'logo2': 'assets/images/wolves_logo.png',
        },
        {
          'team1': 'WOLF PACK',
          'team2': 'COBRA STRIKERS',
          'league': 'International Series',
          'time': 'Completed',
          'maxPrize': '4 Million',
          'team1Code': 'WLF',
          'team2Code': 'CBS',
          'logo1': 'assets/images/wolves_logo.png',
          'logo2': 'assets/images/wolves_logo.png',
        },
      ];
    }
  }

  // Get a random gradient color based on index
  List<Color> getGradientColors(int index) {
    final gradients = [
      [Colors.deepOrange, Colors.black87, Colors.pink],
      [Colors.blue, Colors.black87, Colors.purple],
      [Colors.green, Colors.black87, Colors.teal],
      [Colors.red, Colors.black87, Colors.deepOrange],
      [Colors.purple, Colors.black87, Colors.deepPurple],
    ];

    return gradients[index % gradients.length];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/stadium_bg.jpg',
                fit: BoxFit.cover,
                height: 240,
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "My matches",
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.sports_cricket_outlined, color: Colors.white,),
                            SizedBox(width: 8,),
                            Text(
                              "Cricket",
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildFilterButton('UPCOMING'),
                            const SizedBox(width: 18),
                            _buildFilterButton('LIVE'),
                            const SizedBox(width: 18),
                            _buildFilterButton('COMPLETED'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: isLoading
                        ? Center(child: CircularProgressIndicator(color: Colors.white))
                        : matchesList.isEmpty
                        ? Center(
                      child: Text(
                        'No ${selectedSection.toLowerCase()} matches available',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 40),
                        itemCount: matchesList.length,
                        itemBuilder: (context, index) {
                          final match = matchesList[index];
                          return _buildMatchCard(
                            team1: match['team1'] ?? 'Team 1',
                            team2: match['team2'] ?? 'Team 2',
                            league: match['league'] ?? 'League',
                            time: match['time'] ?? 'Time',
                            maxPrize: match['maxPrize'] ?? 'Prize',
                            colors: getGradientColors(index),
                            logo1: match['logo1'] ?? 'assets/images/wolves_logo.png',
                            logo2: match['logo2'] ?? 'assets/images/wolves_logo.png',
                            team1Code: match['team1Code'] ?? 'T1',
                            team2Code: match['team2Code'] ?? 'T2',
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1, // Set current index to 1 for "My Matches"
          onTap: (index) {
            if (index == 0) {
              // Home tab
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            } else if (index == 2) {
              // Wallet tab
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WalletScreenAdapter()),
              );
            }
            // Already on My Matches tab
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
        )
    );
  }

  // Inside _buildMatchCard method in my_matches_completed.dart, we need to make the card clickable

  Widget _buildMatchCard({
    required String team1,
    required String team2,
    required String league,
    required String time,
    required String maxPrize,
    required List<Color> colors,
    required String logo1,
    required String logo2,
    required String team1Code,
    required String team2Code,
  }) {
    // Set time color based on match status
    Color timeColor = Colors.white;
    if (time.toLowerCase() == 'completed') {
      timeColor = Colors.green;
    } else if (time.toLowerCase() == 'live') {
      timeColor = Colors.red;
    } else {
      timeColor = Colors.yellow; // Upcoming matches
    }

    return GestureDetector(
      onTap: () {
        // Only navigate to match stats for completed matches
        if (time.toLowerCase() == 'completed') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MatchStats(
                matchData: {
                  'team1': team1,
                  'team2': team2,
                  'league': league,
                  'team1Code': team1Code,
                  'team2Code': team2Code,
                  'logo1': logo1,
                  'logo2': logo2,
                  'time': '90 mins', // Default match duration
                },
              ),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The rest of your existing container content...
            // No changes needed here
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 30,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(league, style: const TextStyle(color: Colors.white70)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(team1, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Image.asset(
                              logo1,
                              height: 60,
                              width: 60,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, color: Colors.white)
                          ),
                          const SizedBox(width: 4),
                          Text(team1Code, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 6),
                  Padding(
                    padding: const EdgeInsets.only(top: 19.0),
                    child: Text(
                        time,
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: timeColor)
                    ),
                  ),
                  Column(
                    children: [
                      Text(team2, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(team2Code, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(width: 4),
                          Image.asset(
                              logo2,
                              height: 60,
                              width: 60,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, color: Colors.white)
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Max $maxPrize",
                      style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Icon(Icons.notifications, size: 18, color: Colors.white.withOpacity(0.8)),
                ],
              ),
            )
          ],
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
        // Fetch new data when filter changes
        fetchMatches();
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: isSelected ? Colors.black : Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: isSelected ? Colors.white : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      ),
    );
  }
}