// Class representing a bank account
class Account {
  final String type; // Type of account (e.g., Savings, Checking)
  final String accountNumber; // Unique account number
  final double balance; // Account balance

  // Constructor to initialize an account object
  Account({required this.type, required this.accountNumber, required this.balance});

  // Factory method to create an Account object from JSON data
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      type: json['type'], // Retrieves account type from JSON
      accountNumber: json['account_number'], // Retrieves account number from JSON
      balance: json['balance'].toDouble(), // Converts balance to double to ensure proper data type
    );
  }
}

// Class representing a financial transaction
class Transaction {
  final String date; // Date of the transaction
  final String description; // Description of the transaction (e.g., "Grocery Shopping")
  final double amount; // Transaction amount (positive for income, negative for expense)

  // Constructor to initialize a transaction object
  Transaction({required this.date, required this.description, required this.amount});

  // Factory method to create a Transaction object from JSON data
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      date: json['date'], // Retrieves transaction date from JSON
      description: json['description'], // Retrieves transaction description from JSON
      amount: json['amount'].toDouble(), // Converts amount to double to maintain numerical precision
    );
  }
}
