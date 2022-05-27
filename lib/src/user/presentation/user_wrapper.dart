import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc/src/common/application/certificate/certificate_cubit.dart';
import 'package:nfc/src/common/presentation/components/loading_widget.dart';
import 'package:nfc/src/common/presentation/handlers/error_handler.dart';
import 'package:nfc/src/home/presentation/home_page.dart';
import 'package:nfc/src/user/application/cubit/auth_cubit.dart';
import 'package:nfc/src/user/presentation/user_login_page.dart';

class UserWrapper extends StatelessWidget {
  const UserWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoaded) {
            context.read<AuthCubit>().getUsers();
            context.read<CertificateCubit>().getCertificates();
          } else if (state is AuthFailure) {
            showError(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is UserLoaded) {
            if (state.users.isEmpty) {
              return const UserLoginPage();
            } else {
              return HomePage(user: state.users[0]);
            }
          }

          return const LoadingWidget();
        },
      ),
    );
  }
}
