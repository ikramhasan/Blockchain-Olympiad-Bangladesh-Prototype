import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nfc/src/common/presentation/components/primary_text_field.dart';
import 'package:nfc/src/user/application/cubit/auth_cubit.dart';
import 'package:nfc/src/user/domain/user.dart';

class UserUpdateDialog extends HookWidget {
  const UserUpdateDialog({
    Key? key,
    required this.user,
    required this.isAdmin,
  }) : super(key: key);

  final User user;
  final isAdmin;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final nidController = useTextEditingController();
    final imageController = useTextEditingController();
    final birthDate = useState('');

    useEffect(() {
      nameController.text = user.name;
      nidController.text = user.nid;
      imageController.text = user.imageUrl;
      birthDate.value = user.birthDate;

      return null;
    }, []);

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 150),
      backgroundColor: Theme.of(context).canvasColor,
      content: SizedBox(
        height: 800,
        width: 400,
        child: Column(
          children: [
            const SizedBox(height: 16),
            CircleAvatar(
              backgroundImage: NetworkImage(
                imageController.text,
              ),
              maxRadius: 50,
            ),
            PrimaryTextField(
              controller: nameController,
              label: 'Name',
            ),
            const SizedBox(height: 16),
            PrimaryTextField(
              controller: imageController,
              label: 'Image Url',
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () async {
                final chosenDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.parse(birthDate.value),
                  firstDate: DateTime.parse('19000101'),
                  lastDate: DateTime.now(),
                );

                birthDate.value = chosenDate.toString();
              },
              child: Text(birthDate.value.substring(0, 11)),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (isAdmin) {
              context.read<AuthCubit>().updateUser(
                    name: nameController.text,
                    nid: nidController.text,
                    birthDate: birthDate.value,
                    imageUrl: imageController.text,
                  );
            } else {}
            Navigator.of(context).pop();
          },
          child: Text(isAdmin ? 'Update' : 'Request for change'),
        ),
      ],
    );
  }
}
