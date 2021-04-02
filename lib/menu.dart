import 'package:flutter/material.dart';

class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text("User"),
          accountEmail: Text("@gmail.com"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white70,
            child: Text("T"),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Home"),
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.assessment_rounded),
          title: Text("Task"),
          trailing: Icon(Icons.arrow_right),
          onTap: () {},
        ),
        ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            trailing: Icon(Icons.arrow_right),
            onTap: () {}),
        ListTile(
          leading: Icon(Icons.contact_page),
          title: Text("Contact Us"),
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.announcement_rounded),
          title: Text("About Us"),
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.beenhere_outlined),
          title: Text("Privacy Policy"),
          trailing: Icon(Icons.arrow_right),
        ),
        Divider(),
        ListTile(
            leading: Icon(Icons.logout), title: Text("Logout"), onTap: () {}),
      ],
    );
  }
}
