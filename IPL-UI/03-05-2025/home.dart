import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/FantasyCrick/screens/contest_screen.dart';
import 'package:getx_skeleton/FantasyCrick/screens/my_matches_completed.dart';
import 'package:getx_skeleton/FantasyCrick/screens/wallet_screen_adapter.dart';
import 'package:getx_skeleton/app/modules/my_wallet_screen/bindings/my_wallet_screen_binding.dart';
import 'package:getx_skeleton/app/modules/my_wallet_screen/controllers/my_wallet_screen_controller.dart';
import 'package:getx_skeleton/app/modules/my_wallet_screen/views/my_wallet_screen_view.dart';
import 'package:getx_skeleton/app/services/base_client.dart';
import 'package:getx_skeleton/app/services/api_call_status.dart';

import '../../app/routes/app_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.put(HomeController());
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _homeController.getData(); // Fetch data when the homepage is initialized
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
              height: 200,
            ),
          ),
          SafeArea(
            child: Obx(() {
              if (_homeController.apiCallStatus.value == ApiCallStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_homeController.apiCallStatus.value == ApiCallStatus.error) {
                return const Center(
                  child: Text(
                    "Error fetching data. Please try again later.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }

              final matches = _homeController.matches;

              return Column(
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
                        const Text(
                          "My matches",
                          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            // Replace with your navigation logic
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ContestScreen()));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.3)),
                          ),
                          child: const Text(
                            'View all',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: SizedBox(
                      height: 228,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemCount: matches.isNotEmpty ? matches.length : 1,
                        itemBuilder: (context, index) {
                          if (matches.isEmpty) {
                            return _buildMatchCard(
                              team1: null,
                              team2: null,
                              league: null,
                              time: null,
                              teams: null,
                              contests: null,
                              colors: [Colors.grey, Colors.black, Colors.grey],
                              logo1: null,
                              logo2: null,
                              mode: "myMatches", // Mode to determine what to show at the bottom
                            );
                          }

                          final match = matches[index];
                          return _buildMatchCard(
                            team1: match['team1'],
                            team2: match['team2'],
                            league: match['league'],
                            time: match['time'],
                            teams: match['teams'], // Number of teams
                            contests: match['contests'], // Number of contests
                            colors: [Colors.blue.shade900, Colors.black, Colors.purple],
                            logo1: match['logo1'],
                            logo2: match['logo2'],
                            mode: "myMatches", // Indicating "My Matches" section
                          );
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        matches.isNotEmpty ? matches.length : 1,
                            (index) => Container(
                          margin: const EdgeInsets.all(4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index ? Colors.white : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Text(
                      "Upcoming Matches",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 70),
                        itemCount: matches.isNotEmpty ? matches.length : 1,
                        itemBuilder: (context, index) {
                          if (matches.isEmpty) {
                            return _buildMatchCard(
                              team1: null,
                              team2: null,
                              league: null,
                              time: null,
                              teams: null,
                              contests: null,
                              colors: [Colors.grey, Colors.black, Colors.grey],
                              logo1: null,
                              logo2: null,
                              mode: "upcomingMatches", // Mode for Upcoming Matches
                              price: "N/A",
                            );
                          }

                          final match = matches[index];
                          return _buildMatchCard(
                            team1: match['team1'],
                            team2: match['team2'],
                            league: match['league'],
                            time: match['time'],
                            teams: match['teams'], // Ensure the teams field is passed
                            contests: match['contests'], // Add this line to provide the contests parameter
                            colors: [Colors.blue.shade900, Colors.black, Colors.purple],
                            logo1: match['logo1'],
                            logo2: match['logo2'],
                            mode: "myMatches", // Indicating "My Matches" section
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
        // In home.dart file, update the bottom navigation bar:

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0, // Set current index to 0 for "Home"
          onTap: (index) {
            if (index == 1) {
              // My Matches tab
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Mymatchescompleted()),
              );
            } else if (index == 2) {
              // Wallet tab
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WalletScreenAdapter()),
              );
            }
            // Already on Home tab
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

  Widget _buildMatchCard({
    required String? team1,
    required String? team2,
    required String? league,
    required String? time,
    required int? teams,
    required int? contests,
    required List<Color> colors,
    required String? logo1,
    required String? logo2,
    String? mode, // Determines whether it's "myMatches" or "upcomingMatches"
    String? price, // Max prize for upcoming matches
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
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
                child: Text(
                  league ?? "N/A",
                  style: const TextStyle(color: Colors.white70),
                ),
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
                    Text(team1 ?? "N/A",
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Image.asset(
                          logo1 ?? '',
                          height: 60,
                          width: 60,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image, color: Colors.white),
                        ),
                        const SizedBox(width: 4),
                        const Text('WLS',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.only(top: 19.0),
                  child: Text(time ?? "N/A",
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                ),
                Column(
                  children: [
                    Text(team2 ?? "N/A",
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Text('WLS',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(width: 4),
                        Image.asset(
                          logo2 ?? '',
                          height: 60,
                          width: 60,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
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
                if (mode == "myMatches")
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${teams ?? 0} Team ${contests ?? 0} Contests",
                      style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                if (mode == "upcomingMatches")
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Max ${price ?? 'N/A'}",
                      style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                Icon(Icons.notifications, size: 18, color: Colors.white.withOpacity(0.8)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeController extends GetxController {
  var matches = [].obs;
  var apiCallStatus = ApiCallStatus.holding.obs;

  void getData() async {
    await BaseClient.safeApiCall(
      'https://betpro.gphood.com/api/index', // API endpoint
      RequestType.get,
      onLoading: () {
        apiCallStatus.value = ApiCallStatus.loading;
      },
      onSuccess: (response) {
        matches.value = response.data['matches'] ?? [];
        apiCallStatus.value = ApiCallStatus.success;
      },
      onError: (error) {
        apiCallStatus.value = ApiCallStatus.error;
      },
    );
  }
}