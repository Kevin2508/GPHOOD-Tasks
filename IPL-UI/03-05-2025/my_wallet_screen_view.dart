import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/FantasyCrick/screens/home.dart';
import 'package:getx_skeleton/FantasyCrick/screens/my_matches_completed.dart';
import 'package:getx_skeleton/app/data/models/response/login_response_model.dart';
import 'package:getx_skeleton/app/routes/app_pages.dart';
import 'package:getx_skeleton/app/services/api_call_status.dart';
import 'package:getx_skeleton/app/data/models/response/transaction_log_model.dart';
import '../../app/modules/my_wallet_screen/bindings/my_wallet_screen_binding.dart';
import '../../app/modules/my_wallet_screen/controllers/my_wallet_screen_controller.dart';

class WalletScreenAdapter extends StatelessWidget {
  const WalletScreenAdapter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyWalletScreenBinding().dependencies();

    String currentDate = '2025-05-03 10:09:10';
    String currentUser = 'krishdave-dev';

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/stadium_bg.jpg'),
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
                    SizedBox(width: 40),
                  ],
                ),
              ),
            ),
          ),
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
          Expanded(
            child: ErrorBoundaryWidget(
              child: SafeWalletContent(),
              fallback: (error) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 48),
                    SizedBox(height: 16),
                    Text(
                      'Something went wrong',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      error,
                      style: TextStyle(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Get.find<MyWalletScreenController>().retryAllCalls();
                      },
                      child: Text('Try Again'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2b1b59),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Mymatchescompleted()),
            );
          }
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

class ErrorBoundaryWidget extends StatefulWidget {
  final Widget child;
  final Function(String) fallback;

  const ErrorBoundaryWidget({
    Key? key,
    required this.child,
    required this.fallback,
  }) : super(key: key);

  @override
  State<ErrorBoundaryWidget> createState() => _ErrorBoundaryWidgetState();
}

class _ErrorBoundaryWidgetState extends State<ErrorBoundaryWidget> {
  String? _error;

  @override
  void initState() {
    super.initState();
    ErrorWidget.builder = (FlutterErrorDetails details) {
      setState(() {
        _error = details.exception.toString();
      });
      return widget.fallback(_error!);
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.fallback(_error!);
    }
    return widget.child;
  }
}

class SafeWalletContent extends StatelessWidget {
  const SafeWalletContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWalletScreenController>(
      builder: (controller) {
        if (controller.apiCallStatus == ApiCallStatus.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

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
                    controller.retryAllCalls();
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

        return SingleChildScrollView(
          child: Column(
            children: [
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
                              fontSize: 25.0),
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
                              fontSize: 25.0),
                        )
                      ],
                    ),
                  ],
                ),
              ),
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
                            arguments: [controller.profile]),
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
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Color(0xff1c5d7c),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0)),
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
              _buildApiSafeTransactionsList(controller),
            ],
          ),
        );
      },
    );
  }

  Widget _buildApiSafeTransactionsList(MyWalletScreenController controller) {
    try {
      // Access the transaction data without specifying the type yet
      final transData = controller.transactionLogModel.trans?.data;

      if (transData == null || transData.isEmpty) {
        return _noTransactionsWidget("No transaction history");
      }

      // Create a simplified approach that avoids the type confusion
      return Column(
        children: List.generate(
          transData.length,
              (index) {
            // Access each item directly without declaring its type
            final transaction = transData[index];

            return Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border(bottom: BorderSide(color: Color(0xff151c24)))
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
                  // Access properties directly without specifying type
                  // Use null-aware operators since we know these are dynamic properties
                  transaction?.description ?? "Transaction",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'T. ID: ${transaction?.trx ?? "N/A"}',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      transaction?.createdAt ?? "N/A",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                trailing: Text(
                  '\$${transaction?.amount ?? "0.0"}',
                  style: TextStyle(
                    color: Color(0xff2b1b59),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      );
    } catch (e) {
      print("Error in transaction list: $e");
      return _errorWidget("Could not display transactions: ${e.toString()}");
    }
  }
  Widget _noTransactionsWidget(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.info_outline, color: Colors.white70, size: 32),
            SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _errorWidget(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 32),
            SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(color: Colors.red[300]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}