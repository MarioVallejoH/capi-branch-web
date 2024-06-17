import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:web/src/config/config.dart';
import 'package:web/src/presentation/views/registration/widgets/registration_widgets.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        web: Stack(
          children: [
            Container(
              color: AppColors.primary_100,
            ),
            const RegistrationBody()
          ],
        ),
        mobile: const RegistrationBody(),
      ),
    );
  }
}
