// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:getx_skeleton/FantasyCrick/screens/home.dart';
// import 'package:getx_skeleton/FantasyCrick//screens/my_matches_completed.dart';
// import 'package:getx_skeleton/FantasyCrick//screens/match_stats.dart';
// import 'package:getx_skeleton/FantasyCrick/widgets/contest_card.dart';
//
// class Winnings extends StatefulWidget {
//   const Winnings({super.key});
//
//   @override
//   _WinningsState createState() => _WinningsState();
// }
//
// class _WinningsState extends State<Winnings> {
//   String selectedSection = 'WINNINGS';
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
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         color: Colors.black,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: 90,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/ground.jpg'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: SafeArea(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 0.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => const HomePage(),
//                                     ),
//                                   );
//                                 },
//                                 icon: const Icon(Icons.arrow_back, color: Colors.white),
//                                 constraints: const BoxConstraints(),
//                                 padding: const EdgeInsets.all(8),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(left: 38.0),
//                                 child: Text(
//                                   '0h 9m left',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   IconButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => const MatchStats(),
//                                         ),
//                                       );
//                                     },
//                                     icon: const Icon(Icons.notifications, color: Colors.white),
//                                     constraints: const BoxConstraints(),
//                                     padding: const EdgeInsets.all(8),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => const MyMatchesCompleted(),
//                                         ),
//                                       );
//                                     },
//                                     icon: const Icon(Icons.account_balance_wallet, color: Colors.white),
//                                     constraints: const BoxConstraints(),
//                                     padding: const EdgeInsets.all(8),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
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
//                   padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'WOLVES UNITED',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontSize: 12,
//                         ),
//                       ),
//                       const Text(
//                         'VS',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white70,
//                           fontSize: 12,
//                         ),
//                       ),
//                       const Text(
//                         'COBRA GUARDIANS',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 child: Column(
//                   children: [
//                     ContestCard(
//                       title: 'Max Contest',
//                       prizePool: '\₹5,00,000',
//                       winners: '60% Winners | \₹5,00,000',
//                       spots: '10,000 spots',
//                       spotsLeft: '3,875 spots left',
//                       entryFee: '\₹20',
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 color: const Color(0xff0f1419),
//                 width: double.infinity,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _buildFilterButton('WINNINGS'),
//                         const SizedBox(width: 38),
//                         _buildFilterButton('LEADERBOARD'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 child: selectedSection == 'WINNINGS'
//                     ? const WinningsList()
//                     : const Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Text(
//                     'Leaderboard section coming soon',
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFilterButton(String text) {
//     final isSelected = selectedSection == text;
//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           selectedSection = text;
//         });
//       },
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: 13,
//           fontWeight: FontWeight.bold,
//           color: isSelected ? Colors.black : Colors.white,
//         ),
//       ),
//       style: ElevatedButton.styleFrom(
//         minimumSize: const Size(100, 30),
//         elevation: 0,
//         backgroundColor: isSelected ? Colors.white : const Color(0xff151d24),
//         padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//       ),
//     );
//   }
// }
//
// class WinningsList extends StatelessWidget {
//   const WinningsList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Mock winnings data
//     final winnings = [
//       {'rank': '1st', 'amount': '₹2,00,000'},
//       {'rank': '2nd', 'amount': '₹1,00,000'},
//       {'rank': '3rd', 'amount': '₹50,000'},
//     ];
//
//     return Container(
//       color: Colors.black,
//       padding: const EdgeInsets.all(16.0),
//       child: ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: winnings.length,
//         itemBuilder: (context, index) {
//           final entry = winnings[index];
//           return Container(
//             margin: const EdgeInsets.symmetric(vertical: 4.0),
//             padding: const EdgeInsets.all(12.0),
//             decoration: BoxDecoration(
//               color: const Color(0xff1c252b),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   entry['rank'] as String,
//                   style: const TextStyle(
//                     color: Colors.yellow,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   entry['amount'] as String,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }