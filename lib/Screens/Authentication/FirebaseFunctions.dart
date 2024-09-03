import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method for user signup
  Future<String?> signup({
    required String name,
    required String place,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      // Sign up the user with Firebase Authentication
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user ID
      String uid = userCredential.user!.uid;

      // Create a document in Firestore with additional user information
      await _firestore.collection('Users').doc(uid).set({
        'name': name,
        'place': place,
        'phone': phone,
        'email': email,
      });

      // Return the user ID
      return uid;
    } catch (e) {
      // Handle errors
      print('Signup Error: $e');
      return null;
    }
  }

  // Method for user login
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      // Log in the user with Firebase Authentication
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Return the user ID
      return userCredential.user!.uid;
    } catch (e) {
      // Handle errors
      print('Login Error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print('Failed to sign out: $e');
    }
  }

  // Get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
