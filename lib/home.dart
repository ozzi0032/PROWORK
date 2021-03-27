import 'package:PROWORK/login.dart';
import 'package:flutter/material.dart';
import 'package:PROWORK/serproprofile.dart';

class ServiceProviderhome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Providerhome();
  }
}

class _Providerhome extends State<ServiceProviderhome> {
  int _currentIndex = 0;

  final tabs = [
    Center(
      child: Text("Home"),
    ),
    Center(
      child: Text("Tasks"),
    ),
    Center(child: Profile())
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0, backgroundColor: Colors.cyan),
      drawer: new Drawer(
        child: new ListView(
          children: [
            new UserAccountsDrawerHeader(
              accountName: new Text("User"),
              accountEmail: new Text("@gmail.com"),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.white70,
                child: new Text("T"),
              ),
            ),
            new ListTile(
              leading: new Icon(Icons.home),
              title: new Text("Home"),
              trailing: new Icon(Icons.arrow_right),
            ),
            new ListTile(
              leading: new Icon(Icons.assessment_rounded),
              title: new Text("Task"),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {},
            ),
            new ListTile(
                leading: new Icon(Icons.person),
                title: new Text("Profile"),
                trailing: new Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return tabs[2];
                  }));
                }),
            new ListTile(
              leading: new Icon(Icons.person),
              title: new Text("Contact US"),
              trailing: new Icon(Icons.arrow_right),
            ),
            new ListTile(
              leading: new Icon(Icons.announcement_rounded),
              title: new Text("About Us"),
              trailing: new Icon(Icons.arrow_right),
            ),
            new ListTile(
              leading: new Icon(Icons.beenhere_outlined),
              title: new Text("Privacy Policy"),
              trailing: new Icon(Icons.arrow_right),
            ),
            Divider(),
            new ListTile(
                leading: new Icon(Icons.logout),
                title: new Text("Logout"),
                trailing: new Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Login();
                  }));
                }),
          ],
        ),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.cyan),
              // ignore: deprecated_member_use
              title: Text("Home", style: TextStyle(color: Colors.cyan)),
              backgroundColor: Colors.cyan),
          BottomNavigationBarItem(
              icon: Icon(Icons.assessment_rounded, color: Colors.cyan),
              // ignore: deprecated_member_use
              title: Text("Task", style: TextStyle(color: Colors.cyan)),
              backgroundColor: Colors.cyan),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.cyan),
            // ignore: deprecated_member_use
            title: Text("Profile", style: TextStyle(color: Colors.cyan)),
            backgroundColor: Colors.cyan,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
