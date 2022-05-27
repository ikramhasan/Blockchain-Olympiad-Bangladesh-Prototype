import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc/src/admin/presentation/admin_page.dart';
import 'package:nfc/src/common/presentation/handlers/navigation_handler.dart';
import 'package:nfc/src/intro/components/information_widget.dart';
import 'package:nfc/src/intro/components/login_card.dart';
import 'package:nfc/src/user/presentation/user_wrapper.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 700,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Lottie.asset('assets/blockchain.json', height: 200),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InformationWidget(
                      text: 'Project Name',
                      subText:
                          'A Blockchain-Based Network of Non-interchangeable'
                          ' Academic and Medical Certificates For Authentic'
                          ' Profile Sharing',
                    ),
                    InformationWidget(
                      text: 'Team Name',
                      subText: 'Let There Be Light',
                      subTextWidget: Lottie.asset(
                        'assets/light_effect.json',
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginCard(
                    text: 'Login as a user',
                    subText: 'I want to be able to view my certifications'
                        ' and apply for modifications',
                    icon: const Icon(Icons.person_outline_rounded),
                    onTap: () {
                      goToPage(context, const UserWrapper());
                    },
                  ),
                  const SizedBox(width: 16),
                  LoginCard(
                    text: 'Login as an admin',
                    subText: 'I want to be able to assign new certificates and'
                        ' update them',
                    icon: const Icon(Icons.admin_panel_settings_rounded),
                    onTap: () {
                      goToPage(context, const AdminPage());
                    },
                  ),
                ],
              ),
              const Spacer(),
              const Center(
                child: Text(
                  'This project was built as a prototype for Blockchain Olympiad Bangladesh',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
