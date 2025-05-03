// import 'package:flutter/material.dart';
// import 'dart:ui'; // Required for BackdropFilter
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class PlayerSelection extends StatefulWidget {
//   @override
//   _PlayerSelectionState createState() => _PlayerSelectionState();
// }
//
// class _PlayerSelectionState extends State<PlayerSelection> {
//   String selectedRole = 'WK'; // Default to Wicket-Keeper
//   bool isLoading = true;
//   Map<String, dynamic>? apiData;
//   String timeLeft = 'N/A';
//   String team1 = 'Team 1';
//   String team2 = 'Team 2';
//   String team1Code = 'T1';
//   String team2Code = 'T2';
//   int team1Count = 0;
//   int team2Count = 0;
//   int selection = 0;
//   double credits = 0.0;
//   List<Map<String, dynamic>> playerList = [];
//
//   final teamGradient = LinearGradient(
//     colors: [
//       Color(0xff1c5d7c).withOpacity(1),
//       Colors.black.withOpacity(1),
//       Color(0xff2b1b59).withOpacity(0.8),
//     ],
//     stops: [0.2, 0.5, 1.0],
//     begin: Alignment.centerLeft,
//     end: Alignment.centerRight,
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     try {
//       final response = await http.get(Uri.parse('https://betpro.gphood.com/api/index'));
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           apiData = data;
//           isLoading = false;
//
//           // Set values from API or use defaults if not available
//           timeLeft = data['timeLeft'] ?? 'N/A';
//           team1 = data['team1'] ?? 'Team 1';
//           team2 = data['team2'] ?? 'Team 2';
//           team1Code = data['team1Code'] ?? 'T1';
//           team2Code = data['team2Code'] ?? 'T2';
//           team1Count = data['team1Count'] ?? 0;
//           team2Count = data['team2Count'] ?? 0;
//           selection = data['selection'] ?? 0;
//           credits = data['credits']?.toDouble() ?? 0.0;
//
//           // Extract player list from API data
//           if (data['players'] != null && data['players'] is List) {
//             playerList = List<Map<String, dynamic>>.from(data['players'].map((x) => Map<String, dynamic>.from(x)));
//           } else {
//             // Default player data if not available from API
//             playerList = [
//               {
//                 'name': 'R Jackson',
//                 'role': 'WLS | WK',
//                 'points': 265,
//                 'credits': 10.0,
//                 'selectedBy': '12.0%',
//               },
//               {
//                 'name': 'J Caven',
//                 'role': 'CBR | BAT',
//                 'points': 265,
//                 'credits': 9.5,
//                 'selectedBy': '17.2%',
//               },
//               {
//                 'name': 'P Williamson',
//                 'role': 'CBR | BAT',
//                 'points': 265,
//                 'credits': 9.0,
//                 'selectedBy': '20.2%',
//               },
//               {
//                 'name': 'B Cordero',
//                 'role': 'WLS | DEF',
//                 'points': 265,
//                 'credits': 9.0,
//                 'selectedBy': '17.0%',
//               },
//               {
//                 'name': 'J Donald',
//                 'role': 'CBR | BOWL',
//                 'points': 265,
//                 'credits': 8.5,
//                 'selectedBy': '18.2%',
//               },
//               {
//                 'name': 'R Simmons',
//                 'role': 'WLS | AR',
//                 'points': 265,
//                 'credits': 8.0,
//                 'selectedBy': '19.0%',
//               },
//               {
//                 'name': 'K Smith',
//                 'role': 'CBR | BOWL',
//                 'points': 265,
//                 'credits': 8.0,
//                 'selectedBy': '12.0%',
//               },
//             ];
//           }
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//           // Set default values on error
//         });
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         // Set default values on error
//       });
//       print('Error fetching data: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         color: Colors.black,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Header Section
//               Container(
//                 width: double.infinity,
//                 height: 90,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/stadium_bg.jpg'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: SafeArea(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           onPressed: () {},
//                           icon: Icon(Icons.arrow_back, color: Colors.white),
//                           constraints: BoxConstraints(),
//                           padding: EdgeInsets.all(8),
//                         ),
//                         Text(
//                           '$timeLeft left',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               onPressed: () {},
//                               icon: Icon(Icons.visibility, color: Colors.white),
//                               constraints: BoxConstraints(),
//                               padding: EdgeInsets.all(8),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   gradient: teamGradient,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   team1,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                       fontSize: 11),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(right: 8.0),
//                                       child: apiData?['team1Logo'] != null
//                                           ? Image.network(
//                                         apiData!['team1Logo'],
//                                         fit: BoxFit.cover,
//                                         width: 60,
//                                         height: 60,
//                                         errorBuilder: (context, error, stackTrace) => Image.asset(
//                                           'assets/images/wolves_logo.png',
//                                           fit: BoxFit.cover,
//                                           width: 60,
//                                           height: 60,
//                                         ),
//                                       )
//                                           : Image.asset(
//                                         'assets/images/wolves_logo.png',
//                                         fit: BoxFit.cover,
//                                         width: 60,
//                                         height: 60,
//                                       ),
//                                     ),
//                                     SizedBox(width: 4),
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           team1Code,
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                               fontSize: 12),
//                                         ),
//                                         Text(
//                                           '$team1Count',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                               fontSize: 12),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(bottom: 45.0),
//                                   child: Text(
//                                     'Max 7 player from a team',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white.withOpacity(0.5),
//                                       fontSize: 10,
//                                     ),
//                                   ),
//                                 ),
//                                 Text('$team1Count     :     $team2Count',
//                                     style: TextStyle(
//                                         color: Colors.white.withOpacity(1),
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 12)),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   team2,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                       fontSize: 11),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           team2Code,
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                               fontSize: 12),
//                                         ),
//                                         Text(
//                                           '$team2Count',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                               fontSize: 12),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(width: 4),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 8.0),
//                                       child: apiData?['team2Logo'] != null
//                                           ? Image.network(
//                                         apiData!['team2Logo'],
//                                         fit: BoxFit.cover,
//                                         width: 60,
//                                         height: 60,
//                                         errorBuilder: (context, error, stackTrace) => Image.asset(
//                                           'assets/images/cobra_logo.png',
//                                           fit: BoxFit.cover,
//                                           width: 60,
//                                           height: 60,
//                                         ),
//                                       )
//                                           : Image.asset(
//                                         'assets/images/cobra_logo.png',
//                                         fit: BoxFit.cover,
//                                         width: 60,
//                                         height: 60,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   '$selection/11',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white.withOpacity(1),
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 Text(
//                                   'Selection',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white.withOpacity(0.5),
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             Row(
//                               children: [
//                                 ...List.generate(
//                                   selection > 0 ? selection : 0,
//                                       (index) => Padding(
//                                     padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                                     child: Container(
//                                       width: 10,
//                                       height: 10,
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.green,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 ...List.generate(
//                                   11 - (selection > 0 ? selection : 0),
//                                       (index) => Padding(
//                                     padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                                     child: Container(
//                                       width: 10,
//                                       height: 10,
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   credits.toStringAsFixed(2),
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white.withOpacity(1),
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 Text(
//                                   'Credit',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white.withOpacity(0.5),
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // Filter Buttons
//               Container(
//                 color: Colors.black,
//                 width: double.infinity,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _buildFilterButton('WK', _getRoleCount('WK')),
//                         SizedBox(width: 16),
//                         _buildFilterButton('BAT', _getRoleCount('BAT')),
//                         SizedBox(width: 16),
//                         _buildFilterButton('AR', _getRoleCount('AR')),
//                         SizedBox(width: 16),
//                         _buildFilterButton('BOWL', _getRoleCount('BOWL')),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               // Player List
//               PlayerList(
//                 selectedRole: selectedRole,
//                 playerData: playerList,
//                 onPlayerInfoPress: (player) {
//                   _showPlayerInfoDialog(context, player);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   int _getRoleCount(String role) {
//     return playerList.where((player) {
//       final playerRole = player['role'].toString().split(' | ').last;
//       return playerRole == role;
//     }).length;
//   }
//
//   Widget _buildFilterButton(String role, int count) {
//     final isSelected = selectedRole == role;
//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           selectedRole = role;
//         });
//       },
//       child: Text(
//         '$role ($count)',
//         style: TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: isSelected ? Colors.black : Colors.white,
//         ),
//       ),
//       style: ElevatedButton.styleFrom(
//         minimumSize: Size(75, 20),
//         elevation: 0,
//         backgroundColor: isSelected ? Colors.white : Colors.black,
//         padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//       ),
//     );
//   }
//
//   void _showPlayerInfoDialog(BuildContext context, Map<String, dynamic> player) {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           insetPadding: EdgeInsets.zero,
//           child: Stack(
//             children: [
//               // Blurred background
//               BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                 child: Container(
//                   width: double.infinity,
//                   height: double.infinity,
//                   color: Colors.black.withOpacity(0.5),
//                 ),
//               ),
//               // Full screen player info
//               PlayerInfoPopup(
//                 player: player,
//                 apiData: apiData,
//                 timeLeft: timeLeft,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class PlayerList extends StatelessWidget {
//   final String selectedRole;
//   final List<Map<String, dynamic>> playerData;
//   final Function(Map<String, dynamic>) onPlayerInfoPress;
//
//   PlayerList({
//     required this.selectedRole,
//     required this.playerData,
//     required this.onPlayerInfoPress,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Filter players based on selected role
//     final filteredPlayers = playerData.where((player) {
//       final role = player['role'].toString().split(' | ').last;
//       return role == selectedRole;
//     }).toList();
//
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 11.0, vertical: 8.0),
//       child: Column(
//         children: [
//           // Column Headers
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 7),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   flex: 3,
//                   child: Text(
//                     'Select 3-5 ${selectedRole == 'BOWL' ? 'Bowlers' : selectedRole == 'BAT' ? 'Batsmen' : selectedRole == 'AR' ? 'All-Rounders' : 'Wicket-Keepers'}',
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.5),
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//
//                 Expanded(
//                   flex: 2,
//                   child: Text(
//                     'POINT',
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.5),
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//
//                 Expanded(
//                   flex: 2,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'CREDITS',
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.5),
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.right,
//                       ),
//                       SizedBox(width: 8),
//                       Icon(
//                         Icons.filter_list,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // If no players match the filter
//           if (filteredPlayers.isEmpty)
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'No ${selectedRole} players available',
//                 style: TextStyle(color: Colors.white, fontSize: 14),
//               ),
//             ),
//
//           // Player Data
//           ...filteredPlayers.map((data) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // Player Avatar (Placeholder)
//                         Container(
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.grey[800],
//                           ),
//                           child: data['playerImage'] != null
//                               ? ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: Image.network(
//                               data['playerImage'],
//                               fit: BoxFit.cover,
//                               width: 40,
//                               height: 40,
//                               errorBuilder: (context, error, stackTrace) => Icon(
//                                 Icons.person,
//                                 color: Colors.white,
//                                 size: 30,
//                               ),
//                             ),
//                           )
//                               : Icon(
//                             Icons.person,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         SizedBox(width: 14),
//                         Flexible(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 data['name'] ?? 'N/A',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                               Builder(
//                                 builder: (context) {
//                                   final roleParts = (data['role'] ?? 'NA | NA').toString().split(' | ');
//                                   final teamAbbr = roleParts[0]; // e.g., "WLS"
//                                   // Use 'selectedBy' from API data if available
//                                   final sellByText = 'Sel by ${data['selectedBy'] ?? 'N/A'}';
//                                   return RichText(
//                                     text: TextSpan(
//                                       children: [
//                                         TextSpan(
//                                           text: teamAbbr,
//                                           style: TextStyle(
//                                             color: Colors.purple,
//                                             fontSize: 11,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         TextSpan(
//                                           text: '  ',
//                                           style: TextStyle(
//                                             color: Colors.white.withOpacity(0.6),
//                                             fontSize: 11,
//                                           ),
//                                         ),
//                                         TextSpan(
//                                           text: sellByText,
//                                           style: TextStyle(
//                                             color: Colors.white.withOpacity(0.6),
//                                             fontSize: 11,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Text(
//                       data['points']?.toString() ?? 'N/A',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 4),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             data['credits']?.toString() ?? 'N/A',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             textAlign: TextAlign.right,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           SizedBox(width: 4),
//                           GestureDetector(
//                             onTap: () {
//                               onPlayerInfoPress(data);
//                             },
//                             child: Container(
//                               width: 24,
//                               height: 24,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.green,
//                                   width: 1.5,
//                                 ),
//                                 shape: BoxShape.circle,
//                                 color: Colors.transparent,
//                               ),
//                               child: Center(
//                                 child: Icon(
//                                   Icons.add,
//                                   color: Colors.green,
//                                   size: 16,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ],
//       ),
//     );
//   }
// }
//
// // This class will function as the popup instead of a new screen
// class PlayerInfoPopup extends StatefulWidget {
//   final Map<String, dynamic> player;
//   final Map<String, dynamic>? apiData;
//   final String timeLeft;
//
//   const PlayerInfoPopup({
//     Key? key,
//     required this.player,
//     required this.apiData,
//     required this.timeLeft,
//   }) : super(key: key);
//
//   @override
//   _PlayerInfoPopupState createState() => _PlayerInfoPopupState();
// }
//
// class _PlayerInfoPopupState extends State<PlayerInfoPopup> {
//   bool isLoading = true;
//   List<Map<String, dynamic>> recentMatches = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchPlayerDetails();
//   }
//
//   Future<void> fetchPlayerDetails() async {
//     try {
//       // In a real app, you would fetch the player details from the API using player ID
//       // For now, we'll simulate a delay and use sample data
//       await Future.delayed(Duration(milliseconds: 300));
//
//       // Check if the player data has recentMatches, otherwise use default
//       if (widget.player['recentMatches'] != null && widget.player['recentMatches'] is List) {
//         setState(() {
//           recentMatches = List<Map<String, dynamic>>.from(
//               widget.player['recentMatches'].map((x) => Map<String, dynamic>.from(x)));
//           isLoading = false;
//         });
//       } else {
//         // Create default recent matches if not available
//         setState(() {
//           recentMatches = [
//             {
//               'date': 'JUL 05, 2021',
//               'opponent': 'MXT',
//               'selBy': '20.50%',
//               'points': '325',
//               'credits': '10.0',
//               'color': 'green'
//             },
//             {
//               'date': 'JUL 03, 2021',
//               'opponent': 'BLB',
//               'selBy': '29.70%',
//               'points': '149',
//               'credits': '10.0',
//               'color': 'red'
//             },
//             {
//               'date': 'MAY 29, 2021',
//               'opponent': 'SKC',
//               'selBy': '39.50%',
//               'points': '336',
//               'credits': '10.0',
//               'color': 'blue'
//             },
//             {
//               'date': 'MAY 26, 2021',
//               'opponent': 'PPD',
//               'selBy': '55.50%',
//               'points': '395',
//               'credits': '9.5',
//               'color': 'green'
//             },
//             {
//               'date': 'MAY 23, 2021',
//               'opponent': 'WLS',
//               'selBy': '77.79%',
//               'points': '450',
//               'credits': '9.5',
//               'color': 'yellow'
//             },
//             {
//               'date': 'MAY 19, 2021',
//               'opponent': 'GGS',
//               'selBy': '85.90%',
//               'points': '777',
//               'credits': '9.5',
//               'color': 'orange'
//             },
//           ];
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         // Set defaults on error
//       });
//       print('Error fetching player details: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final name = widget.player['name'] ?? 'N/A';
//     final roleParts = (widget.player['role'] ?? 'NA | NA').toString().split(' | ');
//     final teamAbbr = roleParts[0]; // e.g., "WLS"
//     final playerRole = roleParts.length > 1 ? roleParts[1] : 'N/A';
//     final points = widget.player['points']?.toString() ?? 'N/A';
//     final credits = widget.player['credits']?.toString() ?? 'N/A';
//
//     return Scaffold(
//       backgroundColor: Color(0xff151d24),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Header Section
//             Container(
//               width: double.infinity,
//               height: 90,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/stadium_bg.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: Icon(Icons.arrow_back, color: Colors.white),
//                         constraints: BoxConstraints(),
//                         padding: EdgeInsets.all(8),
//                       ),
//
//                       IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: Icon(Icons.close, color: Colors.white),
//                         constraints: BoxConstraints(),
//                         padding: EdgeInsets.all(8),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             // Player Info Section
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//               color: Color(0xff151d24),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Player Avatar
//                       Container(
//                         width: 100,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.grey[800],
//                         ),
//                         child: widget.player['playerImage'] != null
//                             ? ClipRRect(
//                           borderRadius: BorderRadius.circular(50),
//                           child: Image.network(
//                             widget.player['playerImage'],
//                             fit: BoxFit.cover,
//                             width: 100,
//                             height: 100,
//                             errorBuilder: (context, error, stackTrace) => Icon(
//                               Icons.person,
//                               color: Colors.white,
//                               size: 40,
//                             ),
//                           ),
//                         )
//                             : Icon(
//                           Icons.person,
//                           color: Colors.white,
//                           size: 40,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(width: 16),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         name,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       RichText(
//                         text: TextSpan(
//                           children: [
//                             TextSpan(
//                               text: teamAbbr,
//                               style: TextStyle(
//                                 color: Colors.purple,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             TextSpan(
//                               text: ' | ',
//                               style: TextStyle(
//                                 color: Colors.white.withOpacity(0.6),
//                                 fontSize: 12,
//                               ),
//                             ),
//                             TextSpan(
//                               text: playerRole,
//                               style: TextStyle(
//                                 color: Colors.white.withOpacity(0.6),
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 18),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Point',
//                                     style: TextStyle(
//                                       color: Colors.white.withOpacity(0.6),
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   Text(
//                                     points,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(width: 16),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Credit',
//                                     style: TextStyle(
//                                       color: Colors.white.withOpacity(0.6),
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   Text(
//                                     credits,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(width: 16),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Container(
//                     width: 80,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[700],
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Add player functionality here
//                         Navigator.pop(context); // Close the dialog after adding
//                       },
//                       style: ElevatedButton.styleFrom(
//                         elevation: 0,
//                         backgroundColor: Colors.transparent,
//                         minimumSize: Size(50, 20),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'ADD',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Recent Match Status Section
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               color: Color(0xff0f1419),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Recent match status',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//
//                   if (recentMatches.isEmpty)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 20.0),
//                       child: Center(
//                         child: Text(
//                           'No recent match data available',
//                           style: TextStyle(color: Colors.white, fontSize: 14),
//                         ),
//                       ),
//                     ),
//
//                   // Table Rows with Gradient Backgrounds
//                   ...recentMatches.map((match) {
//                     Color startColor;
//                     switch (match['color']) {
//                       case 'red':
//                         startColor = Colors.red;
//                         break;
//                       case 'blue':
//                         startColor = Colors.blue;
//                         break;
//                       case 'yellow':
//                         startColor = Colors.yellow;
//                         break;
//                       case 'orange':
//                         startColor = Colors.orange;
//                         break;
//                       case 'green':
//                       default:
//                         startColor = Colors.green;
//                     }
//
//                     return _buildMatchRow(
//                       date: match['date'] ?? 'N/A',
//                       opponent: match['opponent'] ?? 'N/A',
//                       selBy: match['selBy'] ?? 'N/A',
//                       points: match['points'] ?? 'N/A',
//                       credits: match['credits'] ?? 'N/A',
//                       gradient: LinearGradient(
//                         colors: [startColor, Color(0xff151d24), Color(0xff151d24), Color(0xff151d24)],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                     );
//                   }).toList(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMatchRow({
//     required String date,
//     required String opponent,
//     required String selBy,
//     required String points,
//     required String credits,
//     required LinearGradient gradient,
//   }) {
//     return Container(
//       height: 100,
//       margin: EdgeInsets.symmetric(vertical: 4.0),
//       decoration: BoxDecoration(
//         gradient: gradient,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             flex: 3,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   date,
//                   style: TextStyle(
//                       color: Colors.white.withOpacity(0.6),
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold
//                   ),
//                 ),
//                 Divider(
//                   color: Color(0xff151d24),
//                   thickness: 1,
//                   height: 5,
//                 ),
//                 SizedBox(height: 5),
//                 Column(
//                   children: [
//                     Text(
//                       'vs',
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.4),
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       opponent,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'SEL BY',
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.6),
//                     fontSize: 10,
//                   ),
//                 ),
//                 Text(
//                   selBy,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'POINT',
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.6),
//                     fontSize: 10,
//                   ),
//                 ),
//                 Text(
//                   points,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'CREDIT',
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.6),
//                     fontSize: 10,
//                   ),
//                 ),
//                 Text(
//                   credits,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }