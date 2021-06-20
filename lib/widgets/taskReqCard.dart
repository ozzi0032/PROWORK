import 'package:flutter/material.dart';

class TaskRequestCard extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final Function onTap;
  TaskRequestCard(
      {@required this.imageUrl, @required this.userName, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: ListTile(
            leading: ClipOval(
              child: CircleAvatar(
                backgroundColor: Colors.orange,
                maxRadius: 25,
                foregroundImage: NetworkImage(imageUrl),
              ),
            ),
            title: Text(userName),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: onTap,
          ),
        ));
  }
}
