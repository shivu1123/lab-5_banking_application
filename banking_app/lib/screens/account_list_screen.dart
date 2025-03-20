import 'package:flutter/material.dart';
import '../models.dart';
import '../data_loader.dart';
import 'transaction_screen.dart';

// Stateful widget to display a list of user accounts
class AccountListScreen extends StatefulWidget {
  @override
  _AccountListScreenState createState() => _AccountListScreenState();
}

class _AccountListScreenState extends State<AccountListScreen> {
  late Future<List<Account>> accountsFuture;

  @override
  void initState() {
    super.initState();
    // Load accounts when the screen initializes
    accountsFuture = loadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Accounts", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).primaryColor.withOpacity(0.3), Colors.white],
          ),
        ),
        child: FutureBuilder<List<Account>>(
          future: accountsFuture,
          builder: (context, snapshot) {
            // Show loading indicator while fetching data
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              );

            List<Account> accounts = snapshot.data!;
            return accounts.isEmpty
                ? Center(child: Text("No accounts found", style: TextStyle(fontSize: 18, color: Colors.grey[700])))
                : Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: accounts.length,
                itemBuilder: (context, index) {
                  Account account = accounts[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: _getAccountColors(account.type),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  account.type,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(_getAccountIcon(account.type), color: Colors.white),
                              ],
                            ),
                            SizedBox(height: 8),
                            // Display last 4 digits of account number
                            Text(
                              "•••• " + account.accountNumber.substring(max(0, account.accountNumber.length - 4)),
                              style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Current Balance",
                                      style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                                    ),
                                    Text(
                                      "\$${account.balance.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigate to transaction screen for selected account
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (_) => TransactionScreen(accountType: account.type),
                                    ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: _getButtonTextColor(account.type),
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    "View Transactions",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  // Function to determine the gradient color based on account type
  List<Color> _getAccountColors(String accountType) {
    switch (accountType.toLowerCase()) {
      case 'checking':
        return [Colors.blue[700]!, Colors.blue[400]!];
      case 'savings':
        return [Colors.green[700]!, Colors.green[400]!];
      case 'credit card':
        return [Colors.purple[700]!, Colors.purple[400]!];
      case 'investment':
        return [Colors.amber[800]!, Colors.amber[500]!];
      default:
        return [Colors.blueGrey[700]!, Colors.blueGrey[400]!];
    }
  }

  // Function to get an icon for each account type
  IconData _getAccountIcon(String accountType) {
    switch (accountType.toLowerCase()) {
      case 'checking':
        return Icons.account_balance;
      case 'savings':
        return Icons.savings;
      case 'credit card':
        return Icons.credit_card;
      case 'investment':
        return Icons.trending_up;
      default:
        return Icons.account_balance_wallet;
    }
  }

  // Function to determine button text color based on account type
  Color _getButtonTextColor(String accountType) {
    switch (accountType.toLowerCase()) {
      case 'checking':
        return Colors.blue[700]!;
      case 'savings':
        return Colors.green[700]!;
      case 'credit card':
        return Colors.purple[700]!;
      case 'investment':
        return Colors.amber[800]!;
      default:
        return Colors.blueGrey[700]!;
    }
  }

  // Helper function to find the maximum of two integers
  int max(int a, int b) {
    return a > b ? a : b;
  }
}
