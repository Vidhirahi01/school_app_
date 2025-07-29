import 'package:flutter/material.dart';
import 'package:school_app_/screens/s_Home_Screen.dart';
import 'package:school_app_/authenticate/authenticate_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({super.key});

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const S_Home()),
      );
    }
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorMessage("Please fill in all fields.");
      return;
    }

    setState(() => _isLoading = true);

    final user = await signIn(email, password);

    setState(() => _isLoading = false);

    if (user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const S_Home()),
      );
    } else {
      _showErrorMessage("Invalid email or password. Please try again.");
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    double responsiveSize(double percentage, {bool isWidth = true}) {
      return isWidth ? screenWidth * percentage : screenHeight * percentage;
    }

    double responsiveFont(double size) {
      return size * (screenWidth / 375.0);
    }

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(26, 22, 43, 1),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      Positioned(
                        left: responsiveSize(0.4),
                        top: responsiveSize(0.1, isWidth: false),
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: responsiveFont(32),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gothic_A1',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: responsiveSize(0.2, isWidth: false),
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: responsiveSize(0.15),
                                  backgroundColor: Colors.pink,
                                  child: Image.asset(
                                    'assets/images/boy.png',
                                    height: responsiveSize(0.2, isWidth: false),
                                    width: responsiveSize(0.3),
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        responsiveSize(0.02, isWidth: false)),
                                Text(
                                  'Student',
                                  style: TextStyle(
                                    fontFamily: 'Gothic_A1',
                                    color: Colors.white,
                                    fontSize: responsiveFont(24),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: responsiveSize(0.50, isWidth: false),
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: responsiveSize(0.1)),
                              child: TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'E-mail',
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: responsiveFont(16),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: responsiveFont(16),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: responsiveSize(0.05, isWidth: false)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: responsiveSize(0.1)),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: responsiveFont(16),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: responsiveFont(16),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: responsiveSize(0.05, isWidth: false)),
                            _isLoading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.red.shade700),
                                  )
                                : TextButton(
                                    onPressed: _handleLogin,
                                    child: const Text('LOGIN',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
