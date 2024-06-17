import 'package:flutter/material.dart';
import 'package:web/src/config/config.dart';
import 'package:web/src/presentation/views/login/widgets/login_form.dart';
import 'package:web/src/presentation/widgets/widgets.dart';
import 'package:web/src/utils/locator.dart';

/// Class to manage login body view
class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      width: GlobalLocator.responsiveDesign.maxWidthValue(400),
      height: GlobalLocator.responsiveDesign.screenHeight,
      child: const SafeArea(
          child: ColumnWithPadding(children: [
        SizedBox(
          height: 16,
        ),
        Placeholder(),
        SizedBox(
          height: 16,
        ),
        Expanded(child: LoginForm()),
        GoToRegistration(),
        SizedBox(
          height: 16,
        ),
      ])),
    );
  }
}
