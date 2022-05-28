import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nfc/src/common/application/application/application_cubit.dart';
import 'package:nfc/src/common/presentation/components/async_image.dart';
import 'package:nfc/src/common/presentation/components/primary_text_field.dart';
import 'package:nfc/src/user/domain/user.dart';

class UpdateUserPage extends HookWidget {
  const UpdateUserPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final imageController = useTextEditingController();
    final birthDate = useState('');

    final subject = useState(<String>['', '', '']);
    final values = useState(<String>['', '', '']);

    useEffect(() {
      nameController.text = user.name;
      imageController.text = user.imageUrl;
      birthDate.value = user.birthDate;

      return null;
    }, []);

    return Column(
      children: [
        const SizedBox(height: 16),
        AsyncImage(url: user.imageUrl, radius: 50),
        PrimaryTextField(
          controller: nameController,
          label: 'Name',
          onChanged: (value) {
            subject.value[0] = 'Name';
            values.value[0] = value;
          },
        ),
        const SizedBox(height: 16),
        PrimaryTextField(
          controller: imageController,
          label: 'Image Url',
          onChanged: (value) {
            subject.value[1] = 'Image Url';
            values.value[1] = value;
          },
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

            subject.value[2] = 'Birth Date';
            values.value[2] = chosenDate.toString();
          },
          child: Text(birthDate.value.substring(0, 11)),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            late String message = 'Update ';
            final updatedSubjects =
                subject.value.where((element) => element.isNotEmpty).toList();
            final updatedMarks =
                values.value.where((element) => element.isNotEmpty).toList();

            for (int i = 0; i < updatedSubjects.length; i++) {
              message = message +
                  updatedSubjects[i] +
                  ' to ' +
                  updatedMarks[i] +
                  ', ';
            }

            context.read<ApplicationCubit>().createApplications(
                  nid: user.nid,
                  message: message.substring(0, message.length - 2),
                  status: 'Pending',
                  applicationType: 'NID',
                );
          },
          child: const Text('Request for change'),
        ),
      ],
    );
  }
}
