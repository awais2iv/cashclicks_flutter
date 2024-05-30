import 'package:flutter/material.dart';
import 'clipper.dart';

class Reciept extends StatelessWidget {
  String? category;
  int ?amount;
  String? date;
  String? description;
  Reciept(
      {this.category, this.amount, this.date, this.description});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                color: Colors.red,
                height: 350, // Adjust height as needed
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 100),
                      child: const Text(
                        'Daily Transaction',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Text(
                       'Rs:$amount'
                        ,style: const TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 300,horizontal: 30),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text("TYPE", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                          Text('$category', style: const TextStyle(fontSize: 15)),
                        ],
                      ),

                      Column(
                        children: [
                          const Text("DATE", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                          Text("$date", style: const TextStyle(fontSize: 15)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 430, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                   Text('$description',
                    style: const TextStyle(fontSize: 20),
                  ),

                  const SizedBox(height: 80),
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                        'images/spendwisely.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
