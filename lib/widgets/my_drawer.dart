import 'package:flutter/material.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/mainScreens/about_me.dart';
import 'package:users_app/mainScreens/profile_screen.dart';
import 'package:users_app/splashScreen/splash_screen.dart';
import '../mainScreens/trip_history_screen.dart';

class MyDrawer extends StatefulWidget {
  final String? name;
  final String? email;

  const MyDrawer({Key? key, this.name, this.email}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //drawer header
          Container(
            height: 175,
            color: Colors.grey,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.email!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          //drawer body
          ListTile(
            leading: const Icon(
              Icons.history,
              color: Colors.white54,
            ),
            title: const Text(
              "History",
              style: TextStyle(color: Colors.white54),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => TripsHistoryScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.white54,
            ),
            title: const Text(
              "Visit Profile",
              style: TextStyle(color: Colors.white54),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => ProfileScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Colors.white54,
            ),
            title: const Text(
              "About",
              style: TextStyle(color: Colors.white54),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => AboutScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.white54,
            ),
            title: const Text(
              "Sign Out",
              style: TextStyle(color: Colors.white54),
            ),
            onTap: () {
              fAuth.signOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => MySlashScreen()));
            },
          ),
        ],
      ),
    );
  }
}
