import 'package:flutter/material.dart';
import 'package:user_listing_app/data/models/UserModel.dart';

import '../pages/UserDetailPage.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.avatar),
      ),
      title: Text('${user.firstName} ${user.lastName}', style: const TextStyle(
        fontFamily: 'SFProText',
        fontWeight: FontWeight.w300,
      )),
      subtitle: Text(user.email),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailPage(userId: user.id),
          ),
        );
      },
    );
  }
}
