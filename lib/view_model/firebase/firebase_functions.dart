import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<String?> getUserStatus(String email) async {
    final QuerySnapshot querySnapshot = await _db
        .collection('User')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs[0]['status'].toString();
    } else {
      return null;
    }
  }

  Future<bool> checkEmailExists(String email) async {
    try {
      print('Checking email: $email');
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
          .collection('User')
          .where('signUpWith', isEqualTo: 'email')
          .limit(1) // Limiting to 1 document for efficiency
          .get();

      print('Query snapshot: ${querySnapshot.docs}');
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      // Handle errors appropriately, e.g., log the error or show a message to the user
      print('Error checking email existence: $e');
      return false;
    }
  }
// Fetch a single user by ID
  Future<UserData?> fetchUserById(String id) async {
    try {
      DocumentSnapshot docSnapshot = await _db.collection('users').doc(id).get();
      if (docSnapshot.exists) {
        return UserData.fromJson(docSnapshot.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }
}

