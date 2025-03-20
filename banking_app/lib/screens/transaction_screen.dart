import 'package:flutter/material.dart';
import '../models.dart';
import '../data_loader.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  final String accountType;
  TransactionScreen({required this.accountType});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late Future<Map<String, List<Transaction>>> transactionsFuture;
  final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
  String _filterOption = 'All';
  final List<String> _filterOptions = ['All', 'Income', 'Expense'];

  @override
  void initState() {
    super.initState();
    transactionsFuture = loadTransactions(); // Load transactions asynchronously
  }

  // Groups transactions by date for display
  Map<String, List<Transaction>> _groupTransactionsByDate(List<Transaction> transactions) {
    Map<String, List<Transaction>> grouped = {};

    for (var transaction in transactions) {
      final dateKey = transaction.date;
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(transaction);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.accountType} Transactions", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).primaryColor.withOpacity(0.1), Colors.white],
          ),
        ),
        child: FutureBuilder<Map<String, List<Transaction>>>(
          future: transactionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Show loading indicator
            } else if (snapshot.hasError) {
              return _buildErrorWidget(); // Show error message
            } else if (!snapshot.hasData || !snapshot.data!.containsKey(widget.accountType)) {
              return _buildNoTransactionWidget(); // Show 'No transactions' message
            }

            List<Transaction> allTransactions = snapshot.data![widget.accountType]!;

            // Apply filter based on user selection
            List<Transaction> filteredTransactions = _applyTransactionFilter(allTransactions);

            if (filteredTransactions.isEmpty) {
              return _buildEmptyFilterResultWidget(); // Show 'No filtered transactions' message
            }

            // Group transactions by date
            var groupedTransactions = _groupTransactionsByDate(filteredTransactions);
            var dateSortedKeys = groupedTransactions.keys.toList()..sort((a, b) => b.compareTo(a));

            return Column(
              children: [
                _buildFilterBar(), // Display filter bar
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: dateSortedKeys.length,
                    itemBuilder: (context, groupIndex) {
                      String dateKey = dateSortedKeys[groupIndex];
                      List<Transaction> dateTransactions = groupedTransactions[dateKey]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              dateKey,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[700]),
                            ),
                          ),
                          ...dateTransactions.map((txn) => _buildTransactionCard(txn)).toList(),
                          SizedBox(height: 8),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Builds the filter dropdown UI
  Widget _buildFilterBar() {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Filter:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          DropdownButton<String>(
            value: _filterOption,
            dropdownColor: Theme.of(context).primaryColor,
            underline: Container(),
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            style: TextStyle(color: Colors.white),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _filterOption = newValue;
                });
              }
            },
            items: _filterOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Builds a transaction card UI
  Widget _buildTransactionCard(Transaction txn) {
    IconData transactionIcon = _getTransactionIcon(txn);

    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            _buildTransactionIcon(txn, transactionIcon),
            SizedBox(width: 16),
            _buildTransactionDetails(txn),
            _buildTransactionAmount(txn),
          ],
        ),
      ),
    );
  }

  // Returns the appropriate icon based on transaction type
  IconData _getTransactionIcon(Transaction txn) {
    String desc = txn.description.toLowerCase();
    if (txn.amount > 0) return Icons.arrow_downward;
    if (desc.contains('bill') || desc.contains('utility')) return Icons.receipt;
    if (desc.contains('grocery') || desc.contains('shop')) return Icons.shopping_cart;
    if (desc.contains('transport')) return Icons.directions_car;
    return Icons.arrow_upward;
  }

  // Applies the selected transaction filter
  List<Transaction> _applyTransactionFilter(List<Transaction> transactions) {
    if (_filterOption == 'Income') {
      return transactions.where((t) => t.amount > 0).toList();
    } else if (_filterOption == 'Expense') {
      return transactions.where((t) => t.amount < 0).toList();
    }
    return transactions;
  }
}
