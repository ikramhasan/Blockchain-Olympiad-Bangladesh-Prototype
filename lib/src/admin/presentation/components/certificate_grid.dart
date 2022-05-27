import 'package:flutter/material.dart';
import 'package:nfc/src/admin/presentation/components/certificate_card.dart';
import 'package:nfc/src/common/domain/certificate.dart';
import 'package:nfc/src/user/domain/user.dart';

class CertificateGrid extends StatelessWidget {
  const CertificateGrid({
    Key? key,
    required this.certificates,
    required this.crossAxisCount,
    required this.users,
    required this.isAdmin,
  }) : super(key: key);

  final List<Certificate> certificates;
  final List<User> users;
  final int crossAxisCount;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: certificates.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) {
        final certificate = certificates[index];

        return SizedBox(
          height: 500,
          child: CertificateCard(
            certificate: certificate,
            user: users
                .where((user) => user.nid == certificate.nid)
                .toList()
                .first,
                isAdmin: isAdmin,
          ),
        );
      },
    );
  }
}
