import 'package:flutter/material.dart';
import 'package:school_app_/authenticate/authenticate_service.dart';

class tMySignUpScreen extends StatefulWidget {
  const tMySignUpScreen({super.key});

  @override
  State<tMySignUpScreen> createState() => _tMySignUpScreen();
}

class _tMySignUpScreen extends State<tMySignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  bool islogin = false;
  String emailAddress = '';
  String password = '';
  String confirmPass = '';

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery with constraints for better responsiveness
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    // Responsive padding and sizing calculations
    double horizontalPadding = screenWidth * (screenWidth > 600 ? 0.2 : 0.1);
    double avatarRadius =
        screenWidth > 600 ? screenWidth * 0.1 : screenWidth * 0.15;
    double fontSize = screenWidth > 600 ? 36 : 32;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 26, 22, 43),
          body: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                    maxWidth: 500), // Max width for larger screens
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.1,
                      ),
                      child: Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gothic_A1',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.1,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 1.0,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'as',
                              style: TextStyle(
                                fontSize: fontSize * 0.75,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Gothic_A1',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: avatarRadius,
                            backgroundColor: Colors.pink,
                            child: Image.asset(
                              'assets/images/prof.png',
                              height: avatarRadius * 2,
                              width: avatarRadius * 2,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Text(
                            'Teacher',
                            style: TextStyle(
                              fontFamily: 'Gothic_A1',
                              color: Colors.white,
                              fontSize: fontSize * 0.75,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Column(
                          children: [
                            _buildTextFormField(
                              key: const ValueKey('email'),
                              labelText: 'E-mail',
                              validator: (value) {
                                if (!(value.toString().contains('@'))) {
                                  return 'Please enter valid email address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                setState(() {
                                  emailAddress = value!;
                                });
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            _buildTextFormField(
                              key: const ValueKey('contact'),
                              labelText: 'Contact No',
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (!(value == null)) {
                                  bool mobilevalid =
                                      RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                          .hasMatch(value);
                                  return mobilevalid ? null : "Invalid mobile";
                                } else {
                                  return 'mobile can\'t be empty';
                                }
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            _buildTextFormField(
                              controller: _pass,
                              key: const ValueKey('password'),
                              labelText: 'Password',
                              obscureText: true,
                              validator: (value) {
                                if (!(value.toString().length <= 6)) {
                                  return 'Please enter password of 6 length';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                setState(() {
                                  password = value!;
                                });
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            _buildTextFormField(
                              controller: _confirmPass,
                              key: const ValueKey('confirmPass'),
                              labelText: 'Confirm Password',
                              obscureText: true,
                              validator: (value) {
                                if (value != _pass.text) {
                                  return 'password not match';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                setState(() {
                                  confirmPass = value!;
                                });
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            _buildSignUpButton(
                                context, screenWidth, screenHeight),
                            SizedBox(height: screenHeight * 0.02),
                            _buildLoginLink(context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextFormField({
    required Key key,
    required String labelText,
    TextInputType? keyboardType,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    bool obscureText = false,
  }) {
    return TextFormField(
      key: key,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildSignUpButton(
      BuildContext context, double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.4,
      child: TextButton(
        style: TextButton.styleFrom(
          side: const BorderSide(color: Colors.red, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            signUp(emailAddress, password);
            Navigator.pushNamed(context, '/tMyLogin');
          }
        },
        child: const Text(
          'SIGN UP',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: 'Gothic_A1',
            letterSpacing: 0.25,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontFamily: 'Gothic_A1',
          fontSize: 16,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.25,
          color: Colors.white,
        ),
        children: [
          const TextSpan(text: 'Already have an account? '),
          WidgetSpan(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/tMyLogin');
              },
              child: const Text(
                'Login Here',
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
        ],
      ),
    );
  }
}
