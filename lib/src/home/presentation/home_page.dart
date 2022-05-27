import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc/src/admin/presentation/components/certificate_grid.dart';
import 'package:nfc/src/admin/presentation/components/create_certificate_drawer.dart';
import 'package:nfc/src/admin/presentation/components/sidebar_tile.dart';
import 'package:nfc/src/common/application/certificate/certificate_cubit.dart';
import 'package:nfc/src/common/presentation/components/loading_widget.dart';
import 'package:nfc/src/user/domain/user.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      endDrawer: const CreateCertificateDrawer(),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                SideBarTile(
                  isActive: true,
                  text: 'Dashboard',
                  onTap: () {},
                  icon: Icons.dashboard_rounded,
                ),
                const Spacer(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      user.imageUrl,
                    ),
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.nid),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const VerticalDivider(),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Certificates',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.white),
                    ),
                    BlocBuilder<CertificateCubit, CertificateState>(
                      builder: (context, state) {
                        if (state is CertificateLoaded) {
                          final certificates = state.certificates
                              .where(
                                  (certificate) => certificate.nid == user.nid)
                              .toList();
                          return CertificateGrid(
                            certificates: certificates,
                            crossAxisCount: 2,
                            users: [user],
                            isAdmin: false,
                          );
                        }

                        return const LoadingWidget();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(),
          const Expanded(
            flex: 1,
            child: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
