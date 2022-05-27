import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc/src/common/application/application/application_cubit.dart';
import 'package:nfc/src/common/domain/application.dart';

class ApplicationPanel extends StatelessWidget {
  const ApplicationPanel({
    Key? key,
    required this.application,
    required this.nid,
  }) : super(key: key);

  final Application application;
  final String nid;

  @override
  Widget build(BuildContext context) {
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
                  application.status,
                  style: TextStyle(
                    color: application.status == 'Pending'
                        ? Colors.yellow
                        : Colors.greenAccent,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Application For'),
                Text(application.applicationType),
              ],
            ),
            const Divider(),
            Text(application.message),
            nid.isNotEmpty
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        application.nid,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Divider(),
                      ElevatedButton(
                        onPressed: () {
                          context.read<ApplicationCubit>().updateApplications(
                                nid: application.nid,
                                message: application.message,
                                status: 'Approved',
                                applicationType: application.applicationType,
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
  }
}
