import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nfc/src/admin/application/cubit/drawer_cubit.dart';
import 'package:nfc/src/admin/presentation/components/user_update_dialog.dart';
import 'package:nfc/src/user/domain/user.dart';

class UserTile extends HookWidget {
  const UserTile({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(user.imageUrl),
      title: Text(user.name),
      subtitle: Text(user.nid),
      trailing: SizedBox(
        width: 300,
        child: Row(
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(100, 50),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => UserUpdateDialog(
                    user: user,
                    isAdmin: true,
                  ),
                );
              },
              child: const Text('Update NID'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(100, 50),
              ),
              onPressed: () {
                context.read<DrawerCubit>().setNID(user.nid, isAdmin: true);
                Scaffold.of(context).openEndDrawer();
              },
              child: const Text('Assign a certificate'),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
