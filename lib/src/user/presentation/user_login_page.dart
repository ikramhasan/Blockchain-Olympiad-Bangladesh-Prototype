import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nfc/src/common/infrastructure/ipfs_service.dart';
import 'package:nfc/src/common/presentation/components/primary_text_field.dart';
import 'package:nfc/src/common/presentation/handlers/error_handler.dart';
import 'package:nfc/src/user/application/cubit/auth_cubit.dart';

class UserLoginPage extends HookWidget {
  const UserLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final nidController = useTextEditingController();
    final birthDate = useState('');
    final fileName = useState('');
    final imagePath = useState('');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Center(
        child: SizedBox(
          width: 700,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Let\'s get to know you!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              imagePath.value.isNotEmpty
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(File(imagePath.value)),
                    )
                  : const SizedBox.shrink(),
              imagePath.value.isNotEmpty
                  ? const SizedBox(height: 16)
                  : const SizedBox.shrink(),
              PrimaryTextField(
                controller: nameController,
                label: 'Name',
              ),
              const SizedBox(height: 16),
              PrimaryTextField(
                controller: nidController,
                label: 'NID',
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () async {
                  final ipfsService = IPFSService();

                  final failureOrSaveFile =
                      await ipfsService.pickImageAndSaveToIPFS();

                  failureOrSaveFile.fold(
                    (l) => showError(context, l.message),
                    (profilePhoto) {
                      imagePath.value = profilePhoto.path;
                      fileName.value = profilePhoto.name;
                    },
                  );
                },
                child: const Text('Upload Image'),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () async {
                  final chosenDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.parse('19000101'),
                    lastDate: DateTime.now(),
                  );

                  if (chosenDate != null) {
                    birthDate.value = chosenDate.toString();
                  } else {
                    showError(context, 'Please select a date');
                  }
                },
                child: Text(
                  birthDate.value.isEmpty
                      ? 'Choose Birth Date'
                      : birthDate.value.substring(0, 11),
                ),
              ),
              const SizedBox(height: 64),
              ElevatedButton(
                onPressed: () {
                  if (birthDate.value.isEmpty) {
                    showError(context, 'Please choose a birth date');
                  } else if (fileName.value.isEmpty) {
                    showError(context, 'Please choose a file');
                  } else {
                    context.read<AuthCubit>().createUser(
                          name: nameController.text,
                          nid: nidController.text,
                          birthDate: birthDate.value,
                          imageUrl: fileName.value,
                        );
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
