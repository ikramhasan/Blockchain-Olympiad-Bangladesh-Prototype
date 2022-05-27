import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nfc/src/admin/application/cubit/drawer_cubit.dart';
import 'package:nfc/src/common/application/application/application_cubit.dart';
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
    final primaryExamType = useState('PSC');

    final subject = useState(<String>['', '', '', '', '', '']);
    final marks = useState(<String>['', '', '', '', '', '']);

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
                primaryExamType.value = certificate.examType;
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
                            marks.value[0] = value;
                            subject.value[0] = 'Exam Type';
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      NumberTextField(
                        controller: banglaController,
                        label: 'Bangla',
                        onChanged: (value) {
                          marks.value[1] = value;
                          subject.value[1] = 'Bangla';
                        },
                      ),
                      const SizedBox(height: 16),
                      NumberTextField(
                        controller: englishController,
                        label: 'English',
                        onChanged: (value) {
                          marks.value[2] = value;
                          subject.value[2] = 'English';
                        },
                      ),
                      const SizedBox(height: 16),
                      NumberTextField(
                        controller: mathController,
                        label: 'Math',
                        onChanged: (value) {
                          marks.value[3] = value;
                          subject.value[3] = 'Math';
                        },
                      ),
                      const SizedBox(height: 16),
                      NumberTextField(
                        controller: scienceController,
                        label: 'Science',
                        onChanged: (value) {
                          marks.value[4] = value;
                          subject.value[4] = 'Science';
                        },
                      ),
                      const SizedBox(height: 16),
                      NumberTextField(
                        controller: religionController,
                        label: 'Religion',
                        onChanged: (value) {
                          marks.value[5] = value;
                          subject.value[5] = 'Religion';
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).colorScheme.secondary,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          if (state.isAdmin) {
                            if (state.certificate == null) {
                              context
                                  .read<CertificateCubit>()
                                  .createCertificate(
                                    nid: state.nid,
                                    examType: examType.value,
                                    bangla: int.parse(banglaController.text),
                                    english: int.parse(englishController.text),
                                    math: int.parse(mathController.text),
                                    science: int.parse(scienceController.text),
                                    religion:
                                        int.parse(religionController.text),
                                  );
                            } else {
                              context
                                  .read<CertificateCubit>()
                                  .updateCertificate(
                                    nid: state.nid,
                                    examType: examType.value,
                                    bangla: int.parse(banglaController.text),
                                    english: int.parse(englishController.text),
                                    math: int.parse(mathController.text),
                                    science: int.parse(scienceController.text),
                                    religion:
                                        int.parse(religionController.text),
                                  );
                            }
                          } else {
                            late String message =
                                'For ${primaryExamType.value} Update ';
                            final updatedSubjects = subject.value
                                .where((element) => element.isNotEmpty)
                                .toList();
                            final updatedMarks = marks.value
                                .where((element) => element.isNotEmpty)
                                .toList();

                            for (int i = 0; i < updatedSubjects.length; i++) {
                              message = message +
                                  updatedSubjects[i] +
                                  ' to ' +
                                  updatedMarks[i] +
                                  ', ';
                            }

                            context.read<ApplicationCubit>().createApplications(
                                  nid: state.nid,
                                  message:
                                      message.substring(0, message.length - 2),
                                  status: 'Pending',
                                  applicationType: 'Certificate',
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
