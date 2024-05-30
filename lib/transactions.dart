import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';
import 'TransactionCard.dart';
import 'reciept.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  late Stream<QuerySnapshot> _transactionsStream;
  String _currentCategory = 'Income'; // Default category

  @override
  void initState() {
    super.initState();
    _transactionsStream = _firebaseService.getTransactions(_currentCategory);
  }

  void _updateTransactionsStream(String category) {
    setState(() {
      _currentCategory = category;
      _transactionsStream = _firebaseService.getTransactions(category);
      print('Fetching transactions for category: $category'); // Debug print
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return false to block back navigation
        return false;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false, // Remove back arrow
            bottom: TabBar(
              indicator: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'Income'),
                Tab(text: 'Expense'),
              ],
              onTap: (index) {
                _updateTransactionsStream(index == 0 ? 'Income' : 'Expense');
              },
            ),
          ),
          body: TabBarView(
            children: [
              _buildTransactionsList('Income'),
              _buildTransactionsList('Expense'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionsList(String category) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseService.getTransactions(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          print('Error: ${snapshot.error}'); // Debug print
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          print('No transactions found'); // Debug print
          return Center(child: Text('No transactions found.'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final transaction = snapshot.data!.docs[index];
            final transactionId = transaction.id;
            return InkWell(
              onTap: (){
                final timestamp = transaction['timestamp'] as Timestamp;
                final dateTime = timestamp.toDate();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Reciept(
                      category: category,
                      amount: transaction['amount'],
                      date: DateFormat('yyyy-MM-dd').format(dateTime),
                      description: transaction['description'],
                    ),
                  ),
                );
              },

              child: TransactionCard(
                category: category,
                description: transaction['description'],
                amount: transaction['amount'],
                onDelete: () => deleteTransaction(category, transactionId),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> deleteTransaction(String category, String transactionId) async {
    try {
      await _firebaseService.deleteTransaction(category, transactionId);
      print('Transaction deleted successfully');
    } catch (e) {
      print('Error deleting transaction: $e');
    }
  }
}
