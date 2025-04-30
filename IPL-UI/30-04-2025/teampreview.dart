import 'package:flutter/material.dart';

class TeamSelection extends StatelessWidget {
  String selectedRole = 'WK';
  final teamGradient = LinearGradient(
    colors: [
      Color(0xff1c5d7c).withOpacity(1),
      Colors.black.withOpacity(1),
      Color(0xff2b1b59).withOpacity(0.8),
    ],
    stops: [0.2, 0.5, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  TeamSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // Green background from screenshot
      body:
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ground.jpg'), // Replace with your image path
            fit: BoxFit.cover, // Ensures the image covers the entire screen
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white),
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
                    IconButton(
                      onPressed: () {
                        // Add edit logic here
                      },
                      icon: Icon(Icons.edit, color: Colors.white),
                      padding: EdgeInsets.all(8),
                    ),
                  ],
                ),
              ),
              // Player Arrangement
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Row 1: 1 Player
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildPlayerWidget(
                          name: 'J Caven',
                          credit: '9.0',
                          isCaptain: false,
                          isViceCaptain: false,
                        ),
                      ],
                    ),
                    // Row 2: 3 Players
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPlayerWidget(
                          name: 'P Willia...',
                          credit: '9.0',
                          isCaptain: true,
                          isViceCaptain: false,
                        ),
                        _buildPlayerWidget(
                          name: 'B Corde...',
                          credit: '9.0',
                          isCaptain: false,
                          isViceCaptain: true,
                        ),
                        _buildPlayerWidget(
                          name: 'R Simm...',
                          credit: '9.0',
                          isCaptain: false,
                          isViceCaptain: false,
                        ),
                      ],
                    ),
                    // Row 3: 4 Players
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPlayerWidget(
                          name: 'K Smith',
                          credit: '8.0',
                          isCaptain: false,
                          isViceCaptain: false,
                        ),
                        _buildPlayerWidget(
                          name: 'M Bruno',
                          credit: '9.0',
                          isCaptain: false,
                          isViceCaptain: false,
                        ),
                        _buildPlayerWidget(
                          name: 'A Andre',
                          credit: '9.0',
                          isCaptain: false,
                          isViceCaptain: false,
                        ),
                        _buildPlayerWidget(
                          name: 'W Ubon',
                          credit: '9.0',
                          isCaptain: false,
                          isViceCaptain: false,
                        ),
                      ],
                    ),
                    // Row 4: 3 Players
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPlayerWidget(
                          name: 'P Johns...',
                          credit: '9.0',
                          isCaptain: false,
                          isViceCaptain: false,
                        ),
                        _buildPlayerWidget(
                          name: 'D Dan...',
                          credit: '9.0',
                          isCaptain: false,
                          isViceCaptain: false,
                        ),
                        _buildPlayerWidget(
                          name: 'L Opero...',
                          credit: '9.0',
                          isCaptain: false,
                          isViceCaptain: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: teamGradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:8,vertical: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Wolves United',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 11),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Image.asset(
                                        'assets/wolves_logo.png',
                                        fit: BoxFit.cover,
                                        width: 60,
                                        height: 60,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'WLS',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '1',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 45.0),
                                  child: Text(
                                    'Max 7 player from a team',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                                Text('5     :     6',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Cobra Guardians',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 11),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'CBR',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '3',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 4),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Image.asset(
                                        'assets/cobra_logo.png',
                                        fit: BoxFit.cover,
                                        width: 60,
                                        height: 60,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '11/11',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(1),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Selection',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ...List.generate(
                                  3,
                                      (index) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                                ...List.generate(
                                  8,
                                      (index) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '0.5',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(1),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Credit',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFilterButton('WK', 0),
                        SizedBox(width: 16),
                        _buildFilterButton('BAT', 0),
                        SizedBox(width: 16),
                        _buildFilterButton('AR', 0),
                        SizedBox(width: 16),
                        _buildFilterButton('BOWL', 0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildFilterButton(String role, int count) {
    final isSelected = selectedRole == role;
    return ElevatedButton(
      onPressed: () {

      },
      child: Text(
        '$role ($count)',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(75, 20),
        elevation: 0,
        backgroundColor: isSelected ? Colors.black : Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
  Widget _buildPlayerWidget({
    required String name,
    required String credit,
    required bool isCaptain,
    required bool isViceCaptain,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.yellow,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Icon(
            Icons.person,
            color: Colors.black,
            size: 40,
          ),
        ),
        SizedBox(height: 4),
        Container(

          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Text(
          credit,
          style: TextStyle(
            color: Colors.white,fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
        if (isCaptain)
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Center(
              child: Text(
                'C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        if (isViceCaptain)
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Center(
              child: Text(
                'VC',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}