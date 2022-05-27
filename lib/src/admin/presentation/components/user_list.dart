import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nfc/src/admin/presentation/components/user_tile.dart';
import 'package:nfc/src/user/domain/user.dart';

class UserListView extends HookWidget {
  const UserListView({
    Key? key,
    required this.users,
  }) : super(key: key);

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final user = users[index];

        return UserTile(user: user);
      },
    );
  }
}
