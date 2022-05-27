import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc/src/admin/application/cubit/drawer_cubit.dart';
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
        BlocProvider<DrawerCubit>(
          create: (context) => DrawerCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blockchain Olympiad Prototype',
        theme: ThemeData(
          canvasColor: const Color(0xFF141132),
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          colorScheme: const ColorScheme.dark(
            secondary: Colors.greenAccent,
          ),
          cardColor: const Color(0xFF0a0a23),
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
              primary: Colors.greenAccent,
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              primary: Colors.greenAccent,
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ),
        home: const IntroPage(),
      ),
    );
  }
}
