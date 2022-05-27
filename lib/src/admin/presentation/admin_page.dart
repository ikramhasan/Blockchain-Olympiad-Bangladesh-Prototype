import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nfc/src/admin/presentation/components/certificate_grid.dart';
import 'package:nfc/src/admin/presentation/components/create_certificate_drawer.dart';
import 'package:nfc/src/admin/presentation/components/search_user_widget.dart';
import 'package:nfc/src/admin/presentation/components/sidebar_tile.dart';
import 'package:nfc/src/admin/presentation/components/user_list.dart';
import 'package:nfc/src/common/application/certificate/certificate_cubit.dart';
import 'package:nfc/src/user/application/cubit/auth_cubit.dart';
import 'package:nfc/src/common/presentation/components/loading_widget.dart';
import 'package:nfc/src/common/presentation/handlers/error_handler.dart';
import 'package:nfc/src/user/domain/user.dart';

class AdminPage extends HookWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageIndex = useState(0);
    final users = useState(<User>[]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Admin'),
      ),
      endDrawer: const CreateCertificateDrawer(),
      body: Center(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SideBarTile(
                    isActive: pageIndex.value == 0,
                    text: 'Users',
                    onTap: () {
                      pageIndex.value = 0;
                    },
                    icon: Icons.person_rounded,
                  ),
                  SideBarTile(
                    isActive: pageIndex.value == 1,
                    text: 'Certificates',
                    onTap: () {
                      pageIndex.value = 1;
                    },
                    icon: Icons.assessment_rounded,
                  ),
                ],
              ),
            ),
            const VerticalDivider(),
            if (pageIndex.value == 0)
              Expanded(
                flex: 5,
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoaded) {
                      context.read<AuthCubit>().getUsers();
                      context.read<CertificateCubit>().getCertificates();
                    } else if (state is UserLoaded) {
                      users.value = state.users;
                    } else if (state is AuthFailure) {
                      showError(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is UserLoaded) {
                      return FadeInUp(
                        child: Column(
                          children: [
                            UserListView(users: state.users),
                          ],
                        ),
                      );
                    }

                    return const LoadingWidget();
                  },
                ),
              )
            else if (pageIndex.value == 1)
              Expanded(
                flex: 5,
                child: BlocBuilder<CertificateCubit, CertificateState>(
                  builder: (context, state) {
                    if (state is CertificateLoaded) {
                      return FadeInUp(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CertificateGrid(
                                certificates: state.certificates,
                                crossAxisCount: 2,
                                users: users.value,
                                isAdmin: true,
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return const LoadingWidget();
                  },
                ),
              ),
            const VerticalDivider(),
            Expanded(
              flex: 1,
              child: SearchUserWidget(users: users.value),
            ),
          ],
        ),
      ),
    );
  }
}
