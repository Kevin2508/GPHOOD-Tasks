import 'package:fantasycricket/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

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
              'assets/stadium_bg.jpg',
              fit: BoxFit.cover,
              height: 200,
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.emoji_events, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            "FantasyCrick",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.sports_cricket, color: Colors.white)
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                   child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         "My matches",
                         style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),
                       ),
                       TextButton(
                         onPressed: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => ContestScreen()), // Ensure HomePage is defined and imported
                           );
                         },
                         style: ButtonStyle(
                           // Customize button color
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.3)),
                              ),
                            

                         child: Text(
                           'View all',
                           style: TextStyle(color: Colors.white), // Customize text color
                         ),
                       ),
                     ],
                   ),
                 ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: SizedBox(
                    height: 220,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      children: [
                        _buildMatchCard(
                          team1: "WOLVES UNITED",
                          team2: "COBRA GUARDIANS",
                          league: "Champion League",
                          time: "0h 9m",
                          maxPrize: "2 Team 3 Contest",
                          colors: [Colors.blue.shade900, Colors.black, Colors.purple],
                          logo1: 'assets/wolves_logo.png',
                          logo2: 'assets/cobra_logo.png',
                        ),
                        _buildMatchCard(
                          team1: "MAXICAN TIGERS",
                          team2: "SHARK CHAMPIONS",
                          league: "IPL League",
                          time: "3h 29m",
                          maxPrize: "2 Team 3 Contest",
                          colors: [Colors.orange, Colors.black, Colors.blue],
                          logo1: 'assets/wolves_logo.png',
                          logo2: 'assets/wolves_logo.png',
                        ),
                        _buildMatchCard(
                          team1: "BLAZZER BULLS",
                          team2: "POWER PANDAS",
                          league: "Premier League",
                          time: "0h 9m",
                          maxPrize: "15 Million",
                          colors: [Colors.red, Colors.black, Colors.teal],
                          logo1: 'assets/wolves_logo.png',
                          logo2: 'assets/wolves_logo.png',
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) => Container(
                      margin: const EdgeInsets.all(4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index ? Colors.white : Colors.grey,
                      ),
                    )),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: Text(
                    "Upcoming Matches",
                    style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: 70),
                      children: [
                        _buildMatchCard(
                          team1: "WOLVES UNITED",
                          team2: "GREAT GORILLAS",
                          league: "Maxican League",
                          time: "3h 29m",
                          maxPrize: "5 Million",
                          colors: [Colors.deepOrange, Colors.black87, Colors.pink],
                          logo1: 'assets/wolves_logo.png',
                          logo2: 'assets/wolves_logo.png',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensures consistent background color
        backgroundColor: Colors.black, // Sets the background color to black
        selectedItemColor: Colors.white, // Color for selected items
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.sports), label: "My Matches"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Wallet"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }

  Widget _buildMatchCard({
    required String team1,
    required String team2,
    required String league,
    required String time,
    required String maxPrize,
    required List<Color> colors,
    required String logo1,
    required String logo2,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(team1, style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold,color: Colors.white)),
                    const SizedBox(height: 6),
                    Image.asset(logo1, height: 60, width: 60, errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, color: Colors.white)),
                  ],
                ),
                const SizedBox(width: 6,),
                Text(time, style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.greenAccent)),

                Column(
                  children: [
                    Text(team2, style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold,color: Colors.white)),
                    const SizedBox(height: 6),
                    Image.asset(logo2, height: 60, width: 60, errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, color: Colors.white)),

                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(league, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF2C2C2E),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Text(
              "Max \₹₹maxPrize",
              style: const TextStyle(fontSize:12,color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
