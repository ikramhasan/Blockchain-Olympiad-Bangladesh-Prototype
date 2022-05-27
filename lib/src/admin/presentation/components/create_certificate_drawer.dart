import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nfc/src/admin/application/cubit/drawer_cubit.dart';
import 'package:nfc/src/common/application/certificate/certificate_cubit.dart';
import 'package:nfc/src/common/presentation/components/number_text_field.dart';

class CreateCertificateDrawer extends HookWidget {
  const CreateCertificateDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final banglaController = useTextEditingController();
    final englishController = useTextEditingController();
    final mathController = useTextEditingController();
    final scienceController = useTextEditingController();
    final religionController = useTextEditingController();
    final examType = useState('PSC');

    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Center(
              child: Text('Assign / Modify a certificate'),
            ),
          ),
          BlocConsumer<DrawerCubit, DrawerState>(
            listener: (context, state) {
              if (state is GotUserData && state.certificate != null) {
                final certificate = state.certificate!;
                banglaController.text = certificate.bangla.toString();
                englishController.text = certificate.english.toString();
                mathController.text = certificate.math.toString();
                scienceController.text = certificate.science.toString();
                religionController.text = certificate.religion.toString();
                examType.value = certificate.examType;
              }
            },
            builder: (context, state) {
              if (state is GotUserData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Exam Type'),
                      const SizedBox(height: 8),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: examType.value,
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(8),
                          items: ['PSC', 'JSC', 'SSC', 'HSC']
                              .map((exam) => DropdownMenuItem<String>(
                                    child: Text(exam),
                                    value: exam,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            examType.value = value!;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      NumberTextField(
                        controller: banglaController,
                        label: 'Bangla',
                      ),
                      const SizedBox(height: 16),
                      NumberTextField(
                        controller: englishController,
                        label: 'English',
                      ),
                      const SizedBox(height: 16),
                      NumberTextField(
                        controller: mathController,
                        label: 'Math',
                      ),
                      const SizedBox(height: 16),
                      NumberTextField(
                        controller: scienceController,
                        label: 'Science',
                      ),
                      const SizedBox(height: 16),
                      NumberTextField(
                        controller: religionController,
                        label: 'Religion',
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).colorScheme.secondary,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          if (state.certificate == null) {
                            context.read<CertificateCubit>().createCertificate(
                                  nid: state.nid,
                                  examType: examType.value,
                                  bangla: int.parse(banglaController.text),
                                  english: int.parse(englishController.text),
                                  math: int.parse(mathController.text),
                                  science: int.parse(scienceController.text),
                                  religion: int.parse(religionController.text),
                                );
                          } else {
                            context.read<CertificateCubit>().updateCertificate(
                                  nid: state.nid,
                                  examType: examType.value,
                                  bangla: int.parse(banglaController.text),
                                  english: int.parse(englishController.text),
                                  math: int.parse(mathController.text),
                                  science: int.parse(scienceController.text),
                                  religion: int.parse(religionController.text),
                                );
                          }

                          Navigator.of(context).pop();
                        },
                        child: Text(
                          state.isAdmin ? 'Assign' : 'Request for change',
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Select a user to assign a certificate'),
              );
            },
          ),
        ],
      ),
    );
  }
}
