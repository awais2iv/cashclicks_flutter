import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final int amount;
  final String description;
  final Function onDelete;
  final String category;


  const TransactionCard({
    required this.amount,
    required this.description,
    required this.onDelete,
    required this.category,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      category == 'Income' ? Icons.arrow_circle_up : Icons.arrow_circle_down,
                      color: category == 'Income' ? Colors.green : Colors.red,
                      size: 40,
                    ),
                    const SizedBox(width: 10), // Add some space between the icon and the amount
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rs.$amount',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5), // Add padding between the amount and the text
                        const Text(
                          "Tap to see Details",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => onDelete(),
                  child: const Text('Delete', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

