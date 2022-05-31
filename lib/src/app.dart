import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc/src/admin/application/cubit/drawer_cubit.dart';
import 'package:nfc/src/common/application/application/application_cubit.dart';
import 'package:nfc/src/common/application/certificate/certificate_cubit.dart';
import 'package:nfc/src/user/application/cubit/auth_cubit.dart';
import 'package:nfc/src/common/infrastructure/auth_repository.dart';
import 'package:nfc/src/intro/intro_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(AuthRepository.instance)..init(),
        ),
        BlocProvider<CertificateCubit>(
          create: (context) => CertificateCubit(AuthRepository.instance),
        ),
        BlocProvider<ApplicationCubit>(
          create: (context) => ApplicationCubit(AuthRepository.instance),
        ),
        BlocProvider<DrawerCubit>(
          create: (context) => DrawerCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blockchain Olympiad Prototype',
        theme: ThemeData(
          canvasColor: const Color(0xFF25242A),
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          colorScheme: const ColorScheme.dark(
            secondary: Color(0xFF6366F1),
          ),
          cardColor: const Color(0xFF302F33),
          listTileTheme: ListTileThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFF6366F1),
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              primary: const Color(0xFF6366F1),
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ),
        home: const IntroPage(),
      ),
    );
  }
}
