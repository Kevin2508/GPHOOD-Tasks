import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/utils/awesome_notifications_helper.dart';

import 'app/data/local/my_shared_pref.dart';
import 'app/routes/app_pages.dart';
import 'config/theme/my_theme.dart';
import 'config/translations/localization_service.dart';
import 'utils/fcm_helper.dart';

Future<void> main() async {
  // wait for bindings
  WidgetsFlutterBinding.ensureInitialized();

  // // initialize local db (hive) and register our custom adapters
  // await MyHive.init(
  //     registerAdapters: (hive) {
  //       hive.registerAdapter(UserModelAdapter());
  //       //myHive.registerAdapter(OtherAdapter());
  //     }
  // );

  // init shared preference
  await MySharedPref.init();

  // inti fcm services
  //await FcmHelper.initFcm();

  // initialize local notifications service
  //await AwesomeNotificationsHelper.init();

  runApp(
    ScreenUtilInit(
      // todo add your (Xd / Figma) artboard size
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        return GetMaterialApp(
              // todo add your app name
              title: "Betpro Baji",
              useInheritedMediaQuery: true,
              debugShowCheckedModeBanner: false,
              builder: (context,widget) {
                bool themeIsLight = MySharedPref.getThemeIsLight();
                return Theme(
                  data: MyTheme.getThemeData(isLight: themeIsLight),
                  child: MediaQuery(
                    // prevent font from scalling (some people use big/small device fonts)
                    // but we want our app font to still the same and dont get affected
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: widget!,
                  ),
                );
              },
              initialRoute: AppPages.INITIAL, // first screen to show when app is running
              getPages: AppPages.routes, // app screens
              locale: MySharedPref.getCurrentLocal(), // app language
              translations: LocalizationService.getInstance(), // localization services in app (controller app language)
            );
      },
    ),
  );
}

class PlayerCard extends StatelessWidget {
  final String team;
  final String points;
  final String wickets;
  final String player1Name;
  final String player2Name;
  final String player1Role;
  final String player2Role;
  final String team1Code;
  final String team2Code;

  PlayerCard({
    required this.team,
    required this.points,
    required this.wickets,
    required this.player1Name,
    required this.player2Name,
    required this.player1Role,
    required this.player2Role,
    required this.team1Code,
    required this.team2Code,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ground.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(team,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 11.5)),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text('$points',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18)),
                                SizedBox(width: 8),
                                Text(team1Code,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14)),
                              ],
                            ),
                            SizedBox(width: 18),
                            Column(
                              children: [
                                Text('$wickets',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18)),
                                Text(team2Code,
                                    style: TextStyle(

                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14)),
                              ],
                            ),
                            SizedBox(width: 8),
                            SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 15),
                            SizedBox(
                              height: 100,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 30,
                                    child: Icon(Icons.person, color: Colors.white),
                                  ),
                                  Positioned(
                                    top: 68,
                                    child: Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[300],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        player1Name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 10,
                                      child: Text('C',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 8)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            SizedBox(height: 15),
                            SizedBox(
                              height: 100,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 30,
                                    child: Icon(Icons.person, color: Colors.white),
                                  ),
                                  Positioned(
                                    top: 68,
                                    child: Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[300],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        player2Name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 10,
                                      child: Text('VC',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 8)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(9),
              decoration: const BoxDecoration(
                color: Color(0xFF2C2C2E),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'WK',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: '(2)',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      )
                    ]),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'WK',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: '(2)',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      )
                    ]),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'WK',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: '(2)',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      )
                    ]),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'WK',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: '(2)',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      )
                    ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class TeamState {
  static final TeamState _instance = TeamState._internal();

  factory TeamState() {
    return _instance;
  }

  TeamState._internal() {
    // Add some default players to complete the 11 if needed
    if (selectedPlayers.isEmpty) {
      _addDefaultPlayers();
    }
  }

  List<Map<String, dynamic>> selectedPlayers = [];
  double totalCredits = 100.0; // Starting credits
  double usedCredits = 0.0;
  int team1Count = 0;
  int team2Count = 0;

  // Captain and vice-captain
  Map<String, dynamic>? captain;
  Map<String, dynamic>? viceCaptain;

  void _addDefaultPlayers() {
    // Only add default players if the list is empty
    List<Map<String, dynamic>> defaultPlayers = [
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
        'role': 'WLS | DEF',
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
    ];

    // Add all default players
    for (var player in defaultPlayers) {
      addPlayer(player);

      // Stop once we have 11 players
      if (selectedPlayers.length >= 11) {
        break;
      }
    }
  }

  void addPlayer(Map<String, dynamic> player) {
    if (!isPlayerSelected(player)) {
      selectedPlayers.add(player);

      // Update credits
      usedCredits += (player['credits'] ?? 0.0);

      // Update team counts
      final teamCode = player['role'].toString().split(' | ')[0];
      if (teamCode == 'WLS') {
        team1Count++;
      } else if (teamCode == 'CBR') {
        team2Count++;
      }
    }
  }

  void removePlayer(Map<String, dynamic> player) {
    int playerIndex = selectedPlayers.indexWhere(
            (p) => p['name'] == player['name']
    );

    if (playerIndex != -1) {
      // Adjust team counts
      final teamCode = player['role'].toString().split(' | ')[0];
      if (teamCode == 'WLS') {
        team1Count--;
      } else if (teamCode == 'CBR') {
        team2Count--;
      }

      // Adjust credits
      usedCredits -= (player['credits'] ?? 0.0);

      // Remove from selected players
      selectedPlayers.removeAt(playerIndex);

      // Clear captain/vice-captain if needed
      if (captain != null && captain!['name'] == player['name']) {
        captain = null;
      }

      if (viceCaptain != null && viceCaptain!['name'] == player['name']) {
        viceCaptain = null;
      }
    }
  }

  bool isPlayerSelected(Map<String, dynamic> player) {
    return selectedPlayers.any((p) => p['name'] == player['name']);
  }

  bool canAddPlayer(Map<String, dynamic> player) {
    // Check if player is already selected
    if (isPlayerSelected(player)) return false;

    // Check if team is full
    if (selectedPlayers.length >= 11) return false;

    // Check if enough credits
    final playerCredits = player['credits'] ?? 0.0;
    if (usedCredits + playerCredits > totalCredits) return false;

    // Check team limits
    final teamCode = player['role'].toString().split(' | ')[0];
    if (teamCode == 'WLS' && team1Count >= 7) return false;
    if (teamCode == 'CBR' && team2Count >= 7) return false;

    return true;
  }

  void setCaptain(Map<String, dynamic> player) {
    // If this player is already the vice-captain, clear that first
    if (viceCaptain != null && viceCaptain!['name'] == player['name']) {
      viceCaptain = null;
    }
    captain = player;
  }

  void setViceCaptain(Map<String, dynamic> player) {
    // If this player is already the captain, clear that first
    if (captain != null && captain!['name'] == player['name']) {
      captain = null;
    }
    viceCaptain = player;
  }

  double getRemainingCredits() {
    return totalCredits - usedCredits;
  }

  bool isTeamComplete() {
    return selectedPlayers.length == 11;
  }

  bool areCaptainsSelected() {
    return captain != null && viceCaptain != null;
  }

  void reset() {
    selectedPlayers = [];
    usedCredits = 0.0;
    team1Count = 0;
    team2Count = 0;
    captain = null;
    viceCaptain = null;
  }
}

