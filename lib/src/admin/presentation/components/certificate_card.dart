import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc/src/admin/application/cubit/drawer_cubit.dart';
import 'package:nfc/src/common/domain/certificate.dart';
import 'package:nfc/src/user/domain/user.dart';

class CertificateCard extends StatelessWidget {
  const CertificateCard({
    Key? key,
    required this.certificate,
    required this.user,
    required this.isAdmin,
  }) : super(key: key);

  final Certificate certificate;
  final User user;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${convertShortFormToFull(certificate.examType)} (${certificate.examType})',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Section(text: 'Name', subText: user.name),
                Section(text: 'NID', subText: user.nid),
              ],
            ),
            const Divider(height: 16),
            SizedBox(
              width: 300,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Section(
                          text: 'Bangla',
                          subText: certificate.bangla.toString()),
                      Section(
                          text: 'English',
                          subText: certificate.english.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Section(
                          text: 'Math', subText: certificate.math.toString()),
                      Section(
                          text: 'Science',
                          subText: certificate.science.toString()),
                    ],
                  ),
                ],
              ),
            ),
            Section(text: 'Religion', subText: certificate.religion.toString()),
            const Divider(height: 16),
            Text(
              'test admin',
              style: GoogleFonts.cedarvilleCursive(fontSize: 18),
            ),
            const Text(
              'Administrator Signature',
              style: TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                context.read<DrawerCubit>().setNID(
                      user.nid,
                      isAdmin: isAdmin,
                      certificate: certificate,
                    );
                Scaffold.of(context).openEndDrawer();
              },
              child: Text(isAdmin ? 'Update' : 'Apply for change'),
            ),
          ],
        ),
      ),
    );
  }
}

String convertShortFormToFull(String text) {
  switch (text) {
    case 'PSC':
      return 'Primary School Certificate';
    case 'JSC':
      return 'Junior School Certificate';
    case 'SSC':
      return 'Secondary School Certificate';
    case 'HSC':
      return 'Higher School Certificate';
    default:
      return 'Certificate';
  }
}

class Section extends StatelessWidget {
  const Section({
    Key? key,
    required this.text,
    required this.subText,
  }) : super(key: key);

  final String text;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 5),
        Text(
          subText,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
