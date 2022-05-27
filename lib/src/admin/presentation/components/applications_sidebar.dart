import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc/src/common/application/application/application_cubit.dart';
import 'package:nfc/src/common/domain/application.dart';
import 'package:nfc/src/common/presentation/components/loading_widget.dart';

class ApplicationsSideBar extends StatelessWidget {
  const ApplicationsSideBar({Key? key, this.nid = ''}) : super(key: key);

  final String nid;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Applications',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        BlocBuilder<ApplicationCubit, ApplicationState>(
          builder: (context, state) {
            if (state is ApplicationLoaded) {
              late List<Application> applications;
              if (nid.isNotEmpty) {
                applications = state.applications
                    .where((application) => application.nid == nid)
                    .toList();
              } else {
                applications = state.applications;
              }
              return ListView.builder(
                itemCount: applications.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Status'),
                              Text(
                                applications[index].status,
                                style: TextStyle(
                                  color: applications[index].status == 'Pending'
                                      ? Colors.yellow
                                      : Colors.greenAccent,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Text(applications[index].message),
                          nid.isNotEmpty
                              ? const SizedBox.shrink()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      applications[index].nid,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    const Divider(),
                                    ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<ApplicationCubit>()
                                            .updateApplications(
                                              nid: applications[index].nid,
                                              message:
                                                  applications[index].message,
                                              status: 'Approved',
                                              applicationType:
                                                  applications[index]
                                                      .applicationType,
                                            );
                                      },
                                      child: const Text('Done'),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return const LoadingWidget();
          },
        ),
      ],
    );
  }
}
