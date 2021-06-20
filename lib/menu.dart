import 'package:PROWORK/screens/onboarding.dart';
import 'package:PROWORK/screens/provider/task_notification.dart';
import 'package:PROWORK/service_locator.dart';
import 'package:PROWORK/viewmodel/user_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuBar extends StatelessWidget {
  final userViewModel = serviceLocator.get<UserViewModel>();
  final _auth = FirebaseAuth.instance;
  User user;
  @override
  Widget build(BuildContext context) {
    user = _auth.currentUser;
    return ListView(
      children: [
        Consumer<UserViewModel>(
          builder: (context, model, child) {
            model.loadUser();
            return UserAccountsDrawerHeader(
              accountName: Text(model.user.fname.toString()),
              accountEmail: Text("${user.phoneNumber}"),
              currentAccountPicture: CircleAvatar(
                foregroundImage: NetworkImage(model.user.profileUrl.toString()),
              ),
            );
          },
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
          onTap: () {
            userViewModel.user.roleType == 'provider'
                ? Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TaskNotification()))
                : null;
          },
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
        Consumer<UserViewModel>(
          builder: (context, model, child) {
            return ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs?.clear();
                  await _auth.signOut();
                  model.clearStorage();

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => OnboardingScreen()),
                      (Route<dynamic> route) => false);
                });
          },
        ),
        /*ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () async {
              await _auth.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => OnboardingScreen()));
            }),*/
      ],
    );
  }
}
