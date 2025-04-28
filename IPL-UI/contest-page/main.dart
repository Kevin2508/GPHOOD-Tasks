import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContestScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ContestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            constraints: BoxConstraints(),
                            padding: EdgeInsets.all(8),
                          ),
                          Text(
                            '0h 9m left',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.notifications, color: Colors.white),
                                constraints: BoxConstraints(),
                                padding: EdgeInsets.all(8),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.account_balance_wallet, color: Colors.white),
                                constraints: BoxConstraints(),
                                padding: EdgeInsets.all(8),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.8),
                      Colors.purple.withOpacity(0.8),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 20,
                              child: Icon(Icons.sports_cricket, color: Colors.white, size: 18),
                            ),
                            SizedBox(height: 4),
                            Text('Wolves United', style: TextStyle(color: Colors.white, fontSize: 12)),
                            Text('WLS', style: TextStyle(color: Colors.white, fontSize: 12)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('vs', style: TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 20,
                              child: Icon(Icons.sports_cricket, color: Colors.white, size: 18),
                            ),
                            SizedBox(height: 4),
                            Text('Cobra Guardians', style: TextStyle(color: Colors.white, fontSize: 12)),
                            Text('CBR', style: TextStyle(color: Colors.white, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  color: Colors.black,
                  child: Row(
                    children: [
                      _buildFilterButton('Contests'),
                      SizedBox(width: 8),
                      _buildFilterButton('My Contests (2)'),
                      SizedBox(width: 8),
                      _buildFilterButton('My Team (3)'),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(8.0),
                children: [
                  ContestCard(
                    title: 'Max Contest',
                    prizePool: '\$5,00,000',
                    winners: '60% Winners | \$5,00,000',
                    spots: '10,000 spots',
                    spotsLeft: '3,875 spots left',
                    entryFee: '\$20',
                  ),
                  ContestCard(
                    title: 'Prize Pool',
                    prizePool: '\$1,00,000',
                    winners: '50% Winners | \$10,000',
                    spots: '30,000 spots',
                    spotsLeft: '5,620 spots left',
                    entryFee: '\$15',
                  ),
                  ContestCard(
                    title: 'Head to Head',
                    prizePool: '\$500',
                    winners: '50% Winners | \$500',
                    spots: '2 spots',
                    spotsLeft: '1 spot left',
                    entryFee: '\$260',
                    isHeadToHead: true,
                  ),
                  ContestCard(
                    title: 'Prize Pool',
                    prizePool: '\$100',
                    winners: '50% Winners | \$50',
                    spots: '2 spots',
                    spotsLeft: '2 spots left',
                    entryFee: '\$52',
                  ),
                  ContestCard(
                    title: 'Prize Pool',
                    prizePool: '\$100',
                    winners: '50% Winners | \$50',
                    spots: '2 spots',
                    spotsLeft: '2 spots left',
                    entryFee: '\$52',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text) {
    return ElevatedButton(
      onPressed: () {},

      child: Text(text, style: TextStyle(fontSize: 13, color: Colors.white)),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      ),

    );
  }
}

class ContestCard extends StatelessWidget {
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
      color: Colors.grey[850],
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(prizePool, style: TextStyle(color: Colors.white, fontSize: 13)),
                SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.5,
                    color: Colors.orange,
                    backgroundColor: Colors.grey,
                  ),
                ),
                SizedBox(width: 8),
                Text(spotsLeft, style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    winners,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    spots,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(entryFee, style: TextStyle(fontSize: 13)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  ),
                ),
              ],
            ),
            if (isHeadToHead) ...[
              SizedBox(height: 6),
              Text(
                'Single Entry',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
