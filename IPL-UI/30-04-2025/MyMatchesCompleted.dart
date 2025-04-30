import 'package:flutter/material.dart';

class Mymatchescompleted extends StatefulWidget {
  const Mymatchescompleted({super.key});

  @override
  State<Mymatchescompleted> createState() => _MyMatchesCompletedState();
}

class _MyMatchesCompletedState extends State<Mymatchescompleted> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  String selectedSection = 'Contests'; // Declare and initialize selectedSection

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
                          Icon(Icons.sports_cricket_outlined,color: Colors.white,),
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
                    color:  Colors.transparent,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: 40),
                      children: [
                        _buildMatchCard(
                          team1: "WOLVES UNITED",
                          team2: "GREAT GORILLAS",
                          league: "Maxican League",
                          time: "Completed",
                          maxPrize: "5 Million",
                          colors: [Colors.deepOrange, Colors.black87, Colors.pink],
                          logo1: 'assets/wolves_logo.png',
                          logo2: 'assets/wolves_logo.png',
                        ),
                        _buildMatchCard(
                          team1: "WOLVES UNITED",
                          team2: "GREAT GORILLAS",
                          league: "Maxican League",
                          time: "Completed",
                          maxPrize: "5 Million",
                          colors: [Colors.deepOrange, Colors.black87, Colors.pink],
                          logo1: 'assets/wolves_logo.png',
                          logo2: 'assets/wolves_logo.png',
                        ),
                        _buildMatchCard(
                          team1: "WOLVES UNITED",
                          team2: "GREAT GORILLAS",
                          league: "Maxican League",
                          time: "Completed",
                          maxPrize: "5 Million",
                          colors: [Colors.deepOrange, Colors.black87, Colors.pink],
                          logo1: 'assets/wolves_logo.png',
                          logo2: 'assets/wolves_logo.png',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: "My Matches"),
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
                        Image.asset(logo1, height: 60, width: 60, errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, color: Colors.white)),
                        const SizedBox(width: 4),
                        const Text('WLS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.only(top: 19.0),
                  child: Text(time, style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold, color: Colors.green)),
                ),
                Column(
                  children: [
                    Text(team2, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Text('WLS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(width: 4),
                        Image.asset(logo2, height: 60, width: 60, errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, color: Colors.white)),
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
        elevation: 0,
        backgroundColor: isSelected ? Colors.white : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      ),
    );
  }
}

class ContestScreen extends StatelessWidget {
  const ContestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contest Screen")),
      body: const Center(child: Text("Contest Screen Content")),
    );
  }
}