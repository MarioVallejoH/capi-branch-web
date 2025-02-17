import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:web/src/config/config.dart';
import 'package:web/src/presentation/views/login/widgets/login_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        web: Stack(
          children: [
            Container(
              color: AppColors.primary_100,
            ),
            const LoginBody()
          ],
        ),
        mobile: const LoginBody(),
      ),
    );
  }
}
