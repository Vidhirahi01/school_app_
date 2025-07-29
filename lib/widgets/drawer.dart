import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer( // Wrap in Drawer for proper styling
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: Text('Options', style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red), // Add logout icon
            title: const Text('Logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            onTap: () async {
              await FirebaseAuth.instance.signOut(); // Sign out the user

              // Close the drawer before navigating
              Navigator.of(context).pop(); 

              // Navigate to login screen & remove all previous screens
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
