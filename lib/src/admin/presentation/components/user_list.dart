import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc/src/admin/application/cubit/drawer_cubit.dart';
import 'package:nfc/src/user/domain/user.dart';

class UserListView extends StatelessWidget {
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
      },
    );
  }
}
