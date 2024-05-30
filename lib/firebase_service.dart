import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> getCurrentUserId() async {
    final User? user = _auth.currentUser;
    // Debug print
    return user?.uid;
  }

  Future<void> addAmount(String category, int amount, String description) async {
    final String? userId = await getCurrentUserId();
    if (userId != null) {
      await _firestore
          .collection(userId)
          .doc(category)
          .collection('transactions')
          .add({
        'amount': amount,
        'description': description,
        'timestamp': Timestamp.now(),
      }).then((value) {
      }).catchError((error) {
      });
    } else {
    }
  }

  Stream<QuerySnapshot> getTransactions(String category) async* {
    final String? userId = await getCurrentUserId();
    if (userId != null) {
      yield* _firestore
          .collection(userId)
          .doc(category)
          .collection('transactions')
          .orderBy('timestamp', descending: true)
          .snapshots();
    } else {
      throw Exception('User ID is null!');
    }
  }

  ///function to get sum of all amount of specific category

  Future<int> getSum(String category) async {
    final String? userId = await getCurrentUserId();
    if (userId != null) {
      int sum = 0;
      await _firestore
          .collection(userId)
          .doc(category)
          .collection('transactions')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          sum += doc['amount'] as int;

        });
      });
      return sum;
    } else {
      throw Exception('User ID is null!');
    }
  }



  ///DELETE THE TRANSACTION...
  Future<void> deleteTransaction(String category, String transactionId) async {
    try {
      final String? userId = await getCurrentUserId();
      if (userId != null) {
        await _firestore
            .collection(userId)
            .doc(category)
            .collection('transactions')
            .doc(transactionId)
            .delete();
      } else {
        throw Exception('User ID is null!');
      }
    } catch (e) {
    }
  }


  ///adding User Details in FIREBASE FIRESTORE....

  Future<void> UserDetails(String name, String email) async {
    final String? userId = await getCurrentUserId();
    if (userId != null) {
      await _firestore
          .collection(userId)
          .doc('UsersDetails')
          .collection('UserInfo')
          .add({
        'name': name,
        'email': email,
        'timestamp': Timestamp.now(),
      }).then((value) {
        print("User details added successfully!");
      }).catchError((error) {
        print("Failed to add user details: $error");
      });
    } else {
      print("User ID is null!");
    }
  }

  ///....GETTING USER DETAILS FROM FIREBASE....
  Stream<QuerySnapshot> getUserDetails(String category) async* {
    final String? userId = await getCurrentUserId();
    if (userId != null) {
      // Debug print
      yield* _firestore
          .collection(userId)
          .doc(category)
          .collection('UserInfo')
          .orderBy('timestamp', descending: true)
          .snapshots();
    } else {
      throw Exception('User ID is null!');
    }
  }

  //function to update the user's name
  Future<void> updateUserName(String newName) async {
    final String? userId = await getCurrentUserId();
    if (userId != null) {
      try {
        QuerySnapshot userInfoSnapshot = await _firestore
            .collection(userId)
            .doc('UsersDetails')
            .collection('UserInfo')
            .get();

        if (userInfoSnapshot.size > 0) {
          String docId = userInfoSnapshot.docs.first.id;
          await _firestore
              .collection(userId)
              .doc('UsersDetails')
              .collection('UserInfo')
              .doc(docId)
              .update({
            'name': newName,
            'timestamp': Timestamp.now(),
          });
        } else {
        }
      } catch (e) {
      }
    } else {
    }
  }

}




