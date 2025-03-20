import 'dart:convert'; // Import for handling JSON encoding and decoding
import 'package:flutter/services.dart'; // Import for loading assets
import 'models.dart'; // Import the models for Account and Transaction

// Function to load a list of accounts from a JSON file
Future<List<Account>> loadAccounts() async {
  // Load the JSON file from the assets folder
  final String response = await rootBundle.loadString('assets/accounts.json');

  // Decode the JSON response and extract the 'accounts' list
  final data = json.decode(response)['accounts'] as List;

  // Convert the list of JSON objects into a list of Account objects
  return data.map((json) => Account.fromJson(json)).toList();
}

// Function to load transactions for each account from a JSON file
Future<Map<String, List<Transaction>>> loadTransactions() async {
  // Load the JSON file from the assets folder
  final String response = await rootBundle.loadString('assets/transactions.json');

  // Decode the JSON response and extract the 'transactions' map
  final Map<String, dynamic> data = json.decode(response)["transactions"];

  // Convert the JSON data into a map where keys are account numbers
  // and values are lists of Transaction objects
  return data.map<String, List<Transaction>>((key, value) {
    return MapEntry(
      key,
      (value as List).map((json) => Transaction.fromJson(json)).toList(),
    );
  });
}
