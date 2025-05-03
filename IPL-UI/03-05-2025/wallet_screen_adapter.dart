import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/FantasyCrick/screens/home.dart';
import 'package:getx_skeleton/FantasyCrick/screens/my_matches_completed.dart';

import 'package:getx_skeleton/app/routes/app_pages.dart';
import 'package:getx_skeleton/app/services/api_call_status.dart';
import 'package:getx_skeleton/app/data/models/response/transaction_log_model.dart';
import '../../app/modules/my_wallet_screen/bindings/my_wallet_screen_binding.dart';
import '../../app/modules/my_wallet_screen/controllers/my_wallet_screen_controller.dart';

class WalletScreenAdapter extends StatelessWidget {
  const WalletScreenAdapter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the wallet screen binding
    MyWalletScreenBinding().dependencies();

    // Using your provided current date and user
    String currentDate = '2025-05-03 11:25:11';
    String currentUser = 'krishdave-dev';

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Header with background image
          Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/ground.jpg'),
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
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.all(8),
                    ),
                    Text(
                      'My Wallet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 40), // Spacer
                  ],
                ),
              ),
            ),
          ),

          // User and date info bar
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Color(0xff151c24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'User: $currentUser',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Date: ${currentDate.split(' ')[0]}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Wallet content wrapped in error handler
          Expanded(
            child: SafeWalletScreenContent(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // "Wallet" tab
        onTap: (index) {
          if (index == 0) {
            // Home tab
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 1) {
            // My Matches tab
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Mymatchescompleted()),
            );
          }
          // Already on Wallet tab (index 2)
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
      ),
    );
  }
}

class SafeWalletScreenContent extends StatelessWidget {
  const SafeWalletScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWalletScreenController>(
      builder: (controller) {
        // Show loading indicator during API calls
        if (controller.apiCallStatus == ApiCallStatus.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        // Show error state if API calls failed
        if (controller.apiCallStatus == ApiCallStatus.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 48),
                SizedBox(height: 16),
                Text(
                  'Failed to load wallet data',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    controller.getProfile();
                    controller.getDeposits();
                    controller.getTransactions();
                  },
                  child: Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff2b1b59),
                  ),
                ),
              ],
            ),
          );
        }

        // If data loaded successfully, show the wallet UI
        return SingleChildScrollView(
          child: Column(
            children: [
              // Balance Container
              Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Color(0xff1c5d7c),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Deposit Balance',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Obx(() => Text(
                          '\$${controller.totalDeposit.value}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0
                          ),
                        )),
                      ],
                    ),
                    Container(
                      width: 2.0,
                      height: 80.0,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    Column(
                      children: [
                        Text(
                          'Current Balance',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          controller.profile.user?.balance != null
                              ? '\$${controller.profile.user!.balance}'
                              : '\$0.0',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              // Deposit/Withdraw Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.DEPOSIT_SCREEN),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff2b1b59),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Deposit'),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed(
                            Routes.WITHDRAWAL_SCREEN,
                            arguments: [controller.profile]
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Color(0xff2b1b59)),
                          ),
                        ),
                        child: const Text('Withdraw'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),

              // Transactions Header
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Color(0xff1c5d7c),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0)
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'All Transactions',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              // Fixed transactions list with proper integer indexing
              _buildFixedTransactionsList(controller),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFixedTransactionsList(MyWalletScreenController controller) {
    // Safely check for null, then extract transaction data
    final transModel = controller.transactionLogModel;
    final transList = transModel.trans?.data;

    // Check if there are any transactions to display
    if (transList == null || transList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'No transactions available',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      );
    }

    // Use explicit int variable for length to avoid any potential issues
    final int transactionCount = transList.length;

    // Use ListView.builder with explicit integer indexing
    return ListView.builder(
      // Use explicit int for itemCount
      itemCount: transactionCount,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // Use a separate function to avoid any issues with the index parameter
      itemBuilder: (context, index) => _buildTransactionItem(transList, index),
    );
  }

  // Separate function for building individual transaction items
  // This ensures proper type handling for the index
  Widget _buildTransactionItem(List<Data> transactions, int index) {
    try {
      // Use the integer index explicitly to access the transaction
      final transaction = transactions[index];

      // Extract data safely with null checks
      final String amount = transaction.amount ?? "0.0";
      final String description = transaction.description ?? "Transaction";
      final String trxId = transaction.trx ?? "N/A";
      String date = "N/A";

      // Format date if available
      if (transaction.createdAt != null) {
        try {
          final DateTime parsedDate = DateTime.parse(transaction.createdAt!);
          date = "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
        } catch (e) {
          // Use raw date if parsing fails
          date = transaction.createdAt!;
        }
      }

      // Build transaction item
      return Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            color: Colors.black,
            border: Border(
                bottom: BorderSide(color: Color(0xff151c24))
            )
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Color(0xff151c24),
            child: Transform.rotate(
                angle: 0.4,
                child: const Icon(Icons.arrow_forward, color: Colors.white)
            ),
          ),
          title: Text(
            description,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'T. ID: $trxId',
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                date,
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          trailing: Text(
            '\$$amount',
            style: TextStyle(
              color: Color(0xff2b1b59),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } catch (e) {
      // Return a placeholder for any errors
      return Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Error displaying transaction",
          style: TextStyle(color: Colors.red[300]),
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}