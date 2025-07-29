import 'package:flutter/material.dart';
import 'package:school_app_/screens/Chat.dart';
import 'package:school_app_/screens/Fees.dart';
import 'package:school_app_/screens/Forgot_password_Screen.dart';
import 'package:school_app_/screens/Notifiy.dart';
import 'package:school_app_/screens/Profile.dart';
import 'package:school_app_/screens/Results.dart';
import 'package:school_app_/screens/Syllabus.dart';
import 'package:school_app_/screens/attendance_screen.dart';
import 'package:school_app_/screens/studentloginScreen.dart';
import 'package:school_app_/screens/schedule.dart';
import 'package:school_app_/screens/studentSignUpScreen.dart';
import 'package:school_app_/screens/t_home.dart';
import 'package:school_app_/widgets/Drawer.dart';
import 'package:school_app_/widgets/overlapContainer.dart';
import '../widgets/Assignments.dart';
import '../widgets/overlapContainer2.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/forgot': (context) => const ForgotPass(),
        '/SignUp': (context) => const MySignUpScreen(),
        '/login': (context) => const MyLoginScreen(),
        '/backLogin': (context) => const MyLoginScreen(),
        '/Attendance': (context) => const Attendance(),
        '/Doubt': (context) => const Chat(),
        '/backhome': (context) => const S_Home(),
        '/Fees': (context) => const Fees(),
        '/Results': (context) => const Results(),
        '/Syllabus': (context) => const syllabus(),
        '/schedule': (context) => const Schedule(),
        '/notify': (context) => const notification(),
      },
    );
  }
}

class S_Home extends StatefulWidget {
  const S_Home({super.key});

  @override
  State<S_Home> createState() => _S_HomeState();
}

class _S_HomeState extends State<S_Home> {
  
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const Attendance(),
    const Chat(),
     Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blue[100],
          backgroundColor: Colors.white,
          labelTextStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Gothic_A1',
            ),
          ),
        ),
        child: NavigationBar(
          height: 60,
          backgroundColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: _selectedIndex,
          animationDuration: const Duration(milliseconds: 500),
          onDestinationSelected: _onItemTapped,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_rounded),
              selectedIcon: Icon(
                Icons.home_outlined,
                color: Colors.red,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_today),
              selectedIcon: Icon(
                Icons.calendar_today_outlined,
                color: Colors.red,
              ),
              label: 'Attendance',
            ),
            NavigationDestination(
              icon: Icon(Icons.chat_bubble_outline),
              selectedIcon: Icon(
                Icons.chat,
                color: Colors.red,
              ),
              label: 'Chat',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(
                Icons.person,
                color: Colors.red,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 26, 22, 43),
      body: _screens[_selectedIndex],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            height: 60,
            width: double.infinity,
            color: const Color.fromARGB(255, 26, 22, 43),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.tune,
                    color: Colors.white,
                  ),
                  iconSize: 30.0,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const notification(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.notifications_none_sharp,
                    color: Colors.white,
                  ),
                  iconSize: 30.0,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color.fromRGBO(194, 216, 227, 0.53),
              ),
              width: double.infinity,
              height: screenHeight * 0.2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Darsh Panchal',
                            style: TextStyle(
                              fontFamily: 'Gothic_A1',
                              fontWeight: FontWeight.w700,
                              fontSize: screenWidth * 0.045,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'Class: ',
                                style: TextStyle(
                                  fontFamily: 'Gothic_A1',
                                  fontWeight: FontWeight.w400,
                                  fontSize: screenWidth * 0.035,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'X-B',
                                style: TextStyle(
                                  fontFamily: 'Gothic_A1',
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth * 0.035,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 25),
                              const Text(
                                '|',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 25),
                              Text(
                                'Roll no: ',
                                style: TextStyle(
                                  fontFamily: 'Gothic_A1',
                                  fontWeight: FontWeight.w400,
                                  fontSize: screenWidth * 0.035,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '24',
                                style: TextStyle(
                                  fontFamily: 'Gothic_A1',
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth * 0.035,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Attendance',
                            style: TextStyle(
                              fontFamily: 'Gothic_A1',
                              fontWeight: FontWeight.w400,
                              fontSize: screenWidth * 0.035,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  borderRadius: BorderRadius.circular(12),
                                  value: 0.822,
                                  backgroundColor: Colors.white,
                                  valueColor:
                                  const AlwaysStoppedAnimation(Colors.red),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '82.2%',
                                style: TextStyle(
                                  fontFamily: 'Gothic_A1',
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth * 0.025,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: screenWidth * 0.1,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: screenWidth * 0.09,
                        backgroundImage:
                        const AssetImage('assets/images/student.jpg'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                    child: Text(
                      'Academics',
                      style: TextStyle(
                        fontFamily: 'Gothic_A1',
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: scrollableIcons(),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today's Classes",
                          style: TextStyle(
                            fontFamily: 'Gothic_A1',
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/schedule');
                          },
                          child: Text(
                            'View All',
                            style: TextStyle(
                              fontFamily: 'Gothic_A1',
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const OverlappingContainers(),
                  const Assignment(),
                  const OverlappingContainers(),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Upcoming Events',
                          style: TextStyle(
                            fontFamily: 'Gothic_A1',
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'View All',
                            style: TextStyle(
                              fontFamily: 'Gothic_A1',
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const OverlappingContainers2(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
