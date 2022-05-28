import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nfc/src/admin/presentation/components/user_update_dialog.dart';
import 'package:nfc/src/common/presentation/components/async_image.dart';
import 'package:nfc/src/user/domain/user.dart';

class SearchUserWidget extends HookWidget {
  const SearchUserWidget({Key? key, required this.users}) : super(key: key);

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    final matchedUser = useState(users);
    final searchController = useTextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Search',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: searchController,
          decoration: const InputDecoration(
            labelText: 'Search by name or NID',
          ),
          onChanged: (value) {
            matchedUser.value = users
                .where((user) =>
                    user.name.toLowerCase().startsWith(value.toLowerCase()) ||
                    user.nid.toLowerCase().startsWith(value.toLowerCase()))
                .toList();
          },
        ),
        ListView.builder(
          itemCount: matchedUser.value.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final user = matchedUser.value[index];

            return ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => UserUpdateDialog(
                    user: user,
                    isAdmin: true,
                  ),
                );
              },
              leading: AsyncImage(url: user.imageUrl),
              title: Text(user.name),
              subtitle: Text(user.nid),
            );
          },
        ),
      ],
    );
  }
}
