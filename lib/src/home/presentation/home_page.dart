import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nfc/src/admin/presentation/components/applications_sidebar.dart';
import 'package:nfc/src/admin/presentation/components/certificate_grid.dart';
import 'package:nfc/src/admin/presentation/components/create_certificate_drawer.dart';
import 'package:nfc/src/admin/presentation/components/sidebar_tile.dart';
import 'package:nfc/src/common/application/certificate/certificate_cubit.dart';
import 'package:nfc/src/common/presentation/components/async_image.dart';
import 'package:nfc/src/common/presentation/components/loading_widget.dart';
import 'package:nfc/src/home/presentation/components/update_user_page.dart';
import 'package:nfc/src/user/domain/user.dart';

class HomePage extends HookWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final pageIndex = useState(0);

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
                  isActive: pageIndex.value == 0,
                  text: 'Dashboard',
                  onTap: () {
                    pageIndex.value = 0;
                  },
                  icon: Icons.dashboard_rounded,
                ),
                SideBarTile(
                  isActive: pageIndex.value == 1,
                  text: 'Digital NID',
                  onTap: () {
                    pageIndex.value = 1;
                  },
                  icon: Icons.badge_rounded,
                ),
                const Spacer(),
                ListTile(
                  leading: AsyncImage(url: user.imageUrl),
                  title: Text(user.name),
                  subtitle: Text(user.nid),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const VerticalDivider(),
          if (pageIndex.value == 0)
            Expanded(
              flex: 6,
              child: FadeInUp(
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
                                  .where((certificate) =>
                                      certificate.nid == user.nid)
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
            )
          else
            Expanded(
              flex: 6,
              child: Center(
                child: SizedBox(
                  width: 400,
                  height: 600,
                  child: FadeInUp(
                    child: UpdateUserPage(user: user),
                  ),
                ),
              ),
            ),
          const VerticalDivider(),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const SizedBox(height: 16),
                ApplicationsSideBar(nid: user.nid),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
