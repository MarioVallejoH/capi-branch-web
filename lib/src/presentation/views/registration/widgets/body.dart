import 'package:flutter/material.dart';
import 'package:web/src/config/config.dart';
import 'package:web/src/presentation/views/registration/widgets/registration_form.dart';
import 'package:web/src/presentation/widgets/widgets.dart';
import 'package:web/src/utils/locator.dart';

/// Class to manage login body view
class RegistrationBody extends StatelessWidget {
  const RegistrationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      width: GlobalLocator.responsiveDesign.maxWidthValue(400),
      height: GlobalLocator.responsiveDesign.screenHeight,
      child: SafeArea(
          child: ColumnWithPadding(children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          'Registro de usuarios',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: 16,
        ),
        const Expanded(child: RegistrationForm()),
        const GoToLogin(),
        const SizedBox(
          height: 16,
        ),
      ])),
    );
  }
}
