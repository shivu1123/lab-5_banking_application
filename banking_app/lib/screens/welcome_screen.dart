import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'account_list_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current date formatted as 'Month Day, Year'
    String today = DateFormat.yMMMMd().format(DateTime.now());

    return Scaffold(
      body: Container(
        // Background gradient effect
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).primaryColor.withOpacity(0.3), Colors.white],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bank Logo - Circular icon with a bank symbol
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.account_balance, size: 50, color: Theme.of(context).primaryColor),
                ),
                SizedBox(height: 20),

                // Welcome message
                Text(
                  "Welcome to Patel Bank",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                SizedBox(height: 10),

                // Display today's date
                Text(
                  "\ud83d\udcc5 $today", // Unicode for a calendar emoji
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 30),

                // 'View Accounts' button to navigate to the account list screen
                ElevatedButton(
                  onPressed: () {
                    // Navigate to AccountListScreen when pressed
                    Navigator.push(context, MaterialPageRoute(builder: (_) => AccountListScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: Text("View Accounts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}