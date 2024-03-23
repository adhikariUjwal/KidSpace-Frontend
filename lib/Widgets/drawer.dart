
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
      width: MediaQuery.of(context).size.width * .7,
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("Ujwal Adhikari"),
            currentAccountPicture: CircleAvatar(),
            accountEmail: null,
          ),
          ListTile(
            leading: const Icon(Icons.person_pin),
            title: const Text('Profile'),
            onTap: () {
              // Navigate to the profile page
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Community'),
            onTap: () {
              // Navigate to the community page
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Setting'),
            onTap: () {
              // Handle settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Payment History'),
            onTap: () {
              // Handle payment history
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () {
              // Navigate to the feedback screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Handle logout
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share With Others'),
            onTap: () {
              // Handle sharing
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help and Feedback'),
            onTap: () {
              // Handle help and feedback
            },
          ),
          const SizedBox(height: 20),
          // const Center(
          //   child: Column(
          //     children: [
          //       Text(
          //         'KidSpace powered',
          //         style: TextStyle(fontSize: 8, fontWeight: FontWeight.normal),
          //       ),
          //       Text('by', style: TextStyle(fontSize: 8)),
          //       Text('Ujwal Adhikari', style: TextStyle(fontSize: 8)),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
