import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPass();
}

class _ForgotPass extends State<ForgotPass> {
  final TextEditingController _email = TextEditingController();

  void handleForgotPassword(String email) async {
    if (email.isEmpty) {
      print("Please enter an email address.");
      return;
    }
    // Add your password reset email logic here
    print("Password reset email sent to $email");
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(26, 22, 43, 1),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.2,
                  top: screenHeight * 0.2,
                ),
                child: const Text(
                  'Forgot Password ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gothic_A1',
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.4),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1,
                      ),
                      child: TextFormField(
                        controller: _email,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const Text(
                      'OR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gothic_A1',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1,
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          labelText: 'Contact No',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    SizedBox(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.06,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          side: const BorderSide(color: Colors.red, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.all(10),
                        ),
                        onPressed: () {
                          if (_email.text.isEmpty) {
                            _showMessage("Please enter an email address.");
                          } else {
                            handleForgotPassword(_email.text);
                            _showMessage(
                              "If the email exists, a reset link has been sent!",
                            );
                          }
                        },
                        child: const Text(
                          textAlign: TextAlign.center,
                          'SEND CODE',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            fontFamily: 'Gothic_A1',
                            letterSpacing: 0.25,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Gothic_A1',
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.25,
                          color: Colors.white,
                        ),
                        children: [
                          const TextSpan(text: "Back to "),
                          WidgetSpan(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/homeSignUp');
                              },
                              child: const SizedBox(
                                height: 20,
                                child: Text(
                                  'SignUp',
                                  style: TextStyle(
                                    fontFamily: 'Gothic_A1',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 0.25,
                                    color: Colors.red,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
