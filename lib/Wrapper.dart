import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:school_app_/screens/s_Home_Screen.dart';
import 'package:school_app_/screens/studentSignUpScreen.dart';
import 'package:school_app_/screens/t_home.dart';
import 'package:school_app_/screens/teacherSignupScreen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Future<bool?>? _userRoleFuture; // Future to handle role fetching

  @override
  void initState() {
    super.initState();
    _userRoleFuture = _checkUserRole(); // Initialize future to fetch role
  }

  Future<bool?> _checkUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return null; // No user logged in
    }

    // Check if role exists in SharedPreferences first
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? storedRole = prefs.getBool('isStudent');

    if (storedRole != null) {
      return storedRole;
    }

    // If not found in SharedPreferences, fetch from Firestore
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        bool fetchedRole = userDoc['isStudent']; // Fetch from Firestore
        await prefs.setBool(
            'isStudent', fetchedRole); // Save to SharedPreferences
        return fetchedRole;
      } else {
        return null; // No user role found
      }
    } catch (e) {
      print("Error fetching user role: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool?>(
      future: _userRoleFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator()); // Show loading spinner
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error loading user role'));
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return FirebaseAuth.instance.currentUser == null
              ? const MySignUpScreen() // Show sign-up screen if no user
              : const Center(child: Text('Role not found!'));
        }

        bool isStudent = snapshot.data!;

        User? user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          // If user is not logged in, navigate to respective sign-up screen
          return isStudent ? const MySignUpScreen() : const tMySignUpScreen();
        }

        // User logged in, navigate to respective home screen
        return isStudent ? const S_Home() : const t_home();
      },
    );
  }
}
