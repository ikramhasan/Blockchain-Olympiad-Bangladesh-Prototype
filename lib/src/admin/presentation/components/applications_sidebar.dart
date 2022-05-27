import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc/src/admin/presentation/components/application_panel.dart';
import 'package:nfc/src/common/application/application/application_cubit.dart';
import 'package:nfc/src/common/domain/application.dart';
import 'package:nfc/src/common/presentation/components/heading_widget.dart';
import 'package:nfc/src/common/presentation/components/loading_widget.dart';

class ApplicationsSideBar extends StatelessWidget {
  const ApplicationsSideBar({
    Key? key,
    this.nid = '',
  }) : super(key: key);

  final String nid;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeadingWidget(text: 'Applications'),
        const SizedBox(height: 16),
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
                  return ApplicationPanel(
                    application: applications[index],
                    nid: nid,
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
