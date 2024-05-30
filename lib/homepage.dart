import 'package:cashclicks/reciept.dart';
import 'package:cashclicks/transactions.dart';
import 'package:flutter/material.dart';
import 'firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'TransactionCard.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FirebaseService _firebaseService = FirebaseService();
  late Stream<QuerySnapshot> _userDetailsStream;

  int totalIncome = 0;
  int totalExpense = 0;
  int totalbalance = 0;

  @override
  void initState() {
    super.initState();
    _fetchTotals();
    _userDetailsStream = _firebaseService.getUserDetails("UsersDetails");
  }

  Future<void> _fetchTotals() async {
    try {
      final int income = await _firebaseService.getSum("Income");
      final int expense = await _firebaseService.getSum("Expense");
      setState(() {
        totalIncome = income;
        totalExpense = expense;
        totalbalance = totalIncome - totalExpense;
      });
    } catch (e) {
      print("Error fetching totals: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> key = GlobalKey();

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        key: key,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 270,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Dashboard",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Row(
                                      children: [
                                        Text(
                                          " Location",
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                        Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Islamabad",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(198, 124, 75, 1)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: "Search Transaction",
                              hintStyle: const TextStyle(color: Colors.grey),
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: Icon(Icons.menu),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 150,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(20, 200, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Text("TOTAL BALANCE: \$$totalbalance",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 150,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Text("Total Income",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15)),
                                    Text("\$$totalIncome",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 150,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Text("Total Expenses",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15)),
                                    Text("\$$totalExpense",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "RECENT TRANSACTIONS",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the Reciept page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TransactionScreen()),
                          );
                        },
                        child: const Text(
                          "View All",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildRecentTransactionsList(),
              //button to open reciept

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentTransactionsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseService.getTransactions('Income'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No transactions found.'));
        }

        final transactions = snapshot.data!.docs.take(4).toList();

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return TransactionCard(
              description: transaction['description'],
              category: 'Income',
              amount: transaction['amount'],
              onDelete: () {
                // Implement delete functionality
              },
            );
          },
        );
      },
    );
  }
}




