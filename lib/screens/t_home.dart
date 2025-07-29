import 'package:flutter/material.dart';
import 'package:school_app_/screens/Chat.dart';
import 'package:school_app_/screens/Fees.dart';
import 'package:school_app_/screens/Forgot_password_Screen.dart';
import 'package:school_app_/screens/Notifiy.dart';
import 'package:school_app_/screens/Profile.dart';
import 'package:school_app_/screens/Results.dart';
import 'package:school_app_/screens/Syllabus.dart';
import 'package:school_app_/screens/studentloginScreen.dart';
import 'package:school_app_/screens/schedule.dart';
import 'package:school_app_/screens/studentSignUpScreen.dart';
import 'package:school_app_/screens/t_attendance.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const t_home(),
        initialRoute: '/',
        routes: {
          '/': (context) => const t_home(),
          '/forgot': (context) => const ForgotPass(),
          '/SignUp': (context) => const MySignUpScreen(),
          '/login': (context) => const MyLoginScreen(),
          '/backLogin': (context) => const MyLoginScreen(),
          '/Doubt': (context) => const Chat(),
          '/backhome': (context) => const t_home(),
          '/Fees': (context) => const Fees(),
          '/Results': (context) => const Results(),
          '/Syllabus': (context) => const syllabus(),
          '/schedule': (context) => const Schedule(),
          '/notify': (context) => const notification()
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/attendance') {
            return MaterialPageRoute(
                builder: (context) => const t_Attendance());
          }
          return null; // Returning null means the route was not found
        });
  }
}

class t_home extends StatefulWidget {
  const t_home({super.key});

  @override
  State<t_home> createState() => _t_home();
}

class _t_home extends State<t_home> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    const tHomeScreen(),
    const t_Attendance(),
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
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blue[100],
          backgroundColor: Colors.white,
          labelTextStyle: const WidgetStatePropertyAll(TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Gothic_A1',
          )),
        ),
        child: NavigationBar(
          height: 60,
          backgroundColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: _selectedIndex,
          animationDuration: const Duration(seconds: 2),
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

// HomeScreen Widget
class tHomeScreen extends StatelessWidget {
  const tHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 60,
          width: double.infinity,
          color: const Color.fromARGB(255, 26, 22, 43),
          child: Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.tune,
                  color: Colors.white,
                  weight: 3,
                ),
                padding: const EdgeInsets.only(left: 20),
                iconSize: 30.0,
                onPressed: () {},
              ),

              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/notify');
                },
                icon: const Icon(
                  Icons.notifications_none_sharp,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(left: 360),
                iconSize: 30.0,
              ),
              // Positioned(
              //   right: 11,
              //   top: 11,
              //   child: Container(
              //     padding: const EdgeInsets.all(2),
              //     decoration: BoxDecoration(
              //       color: Colors.red,
              //       borderRadius: BorderRadius.circular(6),
              //     ),
              //     constraints: const BoxConstraints(
              //       minWidth: 12,
              //       minHeight: 12,
              //     ),
              //     child: const Text(
              //       '1',
              //       style: TextStyle(color: Colors.white, fontSize: 8),
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color.fromRGBO(194, 216, 227, 0.53),
            ),
            width: double.infinity,
            height: 150,
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Poonam patel',
                          style: TextStyle(
                            fontFamily: 'Gothic_A1',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white,
                            letterSpacing: 0.25,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'H.O.D',
                              style: TextStyle(
                                fontFamily: 'Gothic_A1',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Colors.white,
                                letterSpacing: 0.25,
                              ),
                            ),
                            SizedBox(width: 50),
                            Text(
                              '|',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 50),
                            Text(
                              'ID no: ',
                              style: TextStyle(
                                fontFamily: 'Gothic_A1',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Colors.white,
                                letterSpacing: 0.25,
                              ),
                            ),
                            Text(
                              '2210',
                              style: TextStyle(
                                fontFamily: 'Gothic_A1',
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Colors.white,
                                letterSpacing: 0.25,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Attendance',
                          style: TextStyle(
                            fontFamily: 'Gothic_A1',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.white,
                            letterSpacing: 0.25,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 10,
                              width: 180,
                              child: LinearProgressIndicator(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                value: 0.822,
                                backgroundColor: Colors.white,
                                valueColor: AlwaysStoppedAnimation(Colors.red),
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '82.2%',
                              style: TextStyle(
                                fontFamily: 'Gothic_A1',
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Colors.white,
                                letterSpacing: 0.25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: 36,
                      backgroundImage: AssetImage('assets/images/teacher.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ClipRRect(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: double.infinity,
              // height: 200,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                          10,
                        ),
                      ),
                      Text(
                        'Manage',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Gothic_A1',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          letterSpacing: 0.25,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: scrollableIcons(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Today's Classes",
                          style: TextStyle(
                              fontFamily: 'Gothic_A1',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.25),
                        ),
                      ),
                      const SizedBox(
                        width: 170,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/schedule');
                        },
                        child: const Text(
                          "View All",
                          style: TextStyle(
                              fontFamily: 'Gothic_A1',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.25),
                        ),
                      ),
                    ],
                  ),
                  const OverlappingContainers4(),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Upcoming Events",
                          style: TextStyle(
                              fontFamily: 'Gothic_A1',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.25),
                        ),
                      ),
                      const SizedBox(
                        width: 170,
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, '/schedule');
                        },
                        child: const Text(
                          "View All",
                          style: TextStyle(
                              fontFamily: 'Gothic_A1',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.25),
                        ),
                      ),
                    ],
                  ),
                  const OverlappingContainers5(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class scrollableIcons extends StatelessWidget {
  const scrollableIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/attendance');
              },
              child: buildIconContainer(Icons.person_add_alt_1_outlined,
                  'Attendance', const Color.fromRGBO(241, 238, 233, 1)),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/Doubt');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: buildIconContainer(Icons.help_outline, 'Queries?',
                  const Color.fromRGBO(230, 222, 244, 0.93)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/Results');
              },
              child: buildIconContainer(Icons.text_snippet_outlined, 'Results',
                  const Color.fromRGBO(192, 222, 220, 1)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/Calendar');
              },
              child: buildIconContainer(Icons.calendar_today_outlined,
                  'Calendar', const Color.fromRGBO(194, 216, 227, 1)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/Syllabus');
              },
              child: buildIconContainer(Icons.auto_stories_rounded, 'Syllabus',
                  const Color.fromRGBO(241, 238, 233, 1)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/Faculties');
              },
              child: buildIconContainer(Icons.perm_contact_cal_sharp,
                  'Faculties', const Color.fromARGB(255, 216, 233, 219)),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 20.0),
          //   child: InkWell(
          //     onTap: () {
          //       Navigator.pushNamed(context, '/calender');
          //     },
          //     child: buildIconContainer(Icons.calendar_today, 'Calendar',
          //       const Color.fromRGBO(221, 213, 234, 1)),
          //   ),
          // ),
        ],
      ),
    );
  }
}

Widget buildIconContainer(IconData iconData, String label, Color color) {
  return Container(
    height: 85,
    width: 96,
    // margin: EdgeInsets.only(right: 8.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconData,
          size: 38.0,
          color: Colors.black,
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: 'Gothic_A1',
            letterSpacing: 0.25,
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

class OverlappingContainers4 extends StatelessWidget {
  const OverlappingContainers4({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 500,
      height: 150,
      child: Stack(
        children: [
          Positioned(
            left: 75,
            top: 5,
            child: ScheduleCard(
                subject: "Mathematics",
                time: "10:00 to 10:40",
                Class: "10 - B",
                imageUrl: "assets/images/english.png",
                color_: Color.fromRGBO(192, 222, 220, 1)
                // color: const Color.fromRGBO(192, 222, 220, 1),
                ),
          ),
          Positioned(
            left: 10,
            top: 0,
            right: 100,
            child: ScheduleCard(
                subject: "Mathematics",
                time: "10:00 to 10:40",
                Class: "10 - B",
                imageUrl:
                    "assets/images/mathematics.png", // Replace with your image path,
                color_: Color.fromRGBO(216, 209, 231, 1)),
          ),
        ],
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String subject;
  final String time;
  final String Class;
  final String imageUrl;
  final Color color_;
  const ScheduleCard(
      {super.key,
      required this.subject,
      required this.time,
      required this.Class,
      required this.imageUrl,
      required this.color_});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3.0,
      child: Container(
        width: 267,
        height: 126,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color_,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Class – $Class",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imageUrl,
                width: 66,
                height: 66,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OverlappingContainers5 extends StatelessWidget {
  const OverlappingContainers5({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 133,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            EventCard(
              EventName: 'Technical Fest',
              imageUrl: "assets/images/fest.png",
            ),
            SizedBox(
              width: 10,
            ),
            EventCard(
              EventName: 'Sports Day celebration',
              imageUrl: "assets/images/sports.png",
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String EventName;
  final String imageUrl;

  const EventCard({
    super.key,
    required this.EventName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              imageUrl,
              width: 268,
              height: 86,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 50,
          bottom: 60,
          left: 20,
          child: Text(
            EventName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
