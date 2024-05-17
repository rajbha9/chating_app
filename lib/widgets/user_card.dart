import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserCard extends StatefulWidget {
  final ChatUser user;

  const UserCard({super.key, required this.user});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: InkWell(
          onTap: () {},
          child: ListTile(
            leading: FlutterLogo(),
            trailing: Icon(Icons.more_vert),
            subtitle: Text(widget.user.about),
            title: Text(widget.user.name),
          ),
        ),
      ),
    );
  }
}
