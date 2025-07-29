import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:school_app_/firebase_options.dart';
import 'package:school_app_/screens/Forgot_password_Screen.dart';
import 'package:school_app_/screens/studentSignUpScreen.dart';
import 'package:school_app_/screens/studentloginScreen.dart';
import 'package:school_app_/screens/teacherLoginScreen.dart';
import 'package:school_app_/screens/teacherSignupScreen.dart';
import 'package:school_app_/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School For Everyone',
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => const MainSignUpScreen(),
        '/Wrapper': (context) => const Wrapper(),
        '/StudentSignUp': (context) => const MySignUpScreen(),
        '/studentlogin': (context) => const MyLoginScreen(),
        '/teacherSignUp': (context) => const tMySignUpScreen(),
        '/tMyLogin': (context) => const tMyLoginScreen(),
        '/forgot': (context) => const ForgotPass(),
        '/homeSignUp': (context) => const MainSignUpScreen(),
        '/drawer': (context) => const Drawer()
      },
    );
  }
}

class MainSignUpScreen extends StatelessWidget {
  const MainSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1A2E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.1),
              // App Title
              const Text(
                "SCHOOL FOR EVERYONE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),

              // Main Image
              CircleAvatar(
                radius: screenWidth * 0.25,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/images/signupMain.png', // Replace with your main image path
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Sign Up Title
              const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const Text(
                "as",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white60,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Options (Student, Teacher, Parent, Admin)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: screenHeight * 0.03,
                  crossAxisSpacing: screenWidth * 0.05,
                  children: [
                    _buildOptionButton(
                      context,
                      "Student",
                      "assets/images/boy.png",
                      onTap: () => Navigator.pushNamed(context, '/Wrapper',
                          arguments: {'isStudent': true}),
                    ),
                    _buildOptionButton(
                      context,
                      "Teacher",
                      "assets/images/prof.png",
                      onTap: () => Navigator.pushNamed(context, '/Wrapper',
                          arguments: {'isStudent': false}),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for each button
  Widget _buildOptionButton(
      BuildContext context, String label, String imagePath,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 50, // Adjust radius based on screen width
            backgroundColor: const Color(0xFFD75C5C),
            child: Image.asset(
              imagePath,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
