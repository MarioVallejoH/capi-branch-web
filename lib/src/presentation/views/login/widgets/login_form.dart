import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web/src/config/router/custom_router.dart';
import 'package:web/src/data/repositories/user_repository.dart';
import 'package:web/src/domain/dtos/dtos.dart';
import 'package:web/src/presentation/state/login_form.dart';
import 'package:web/src/presentation/widgets/scroll_column_expandable.dart';
import 'package:web/src/presentation/widgets/widgets.dart';
import 'package:web/src/utils/utils.dart';

/// User login form
class LoginForm extends ConsumerStatefulWidget {
  /// Constructor
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _passwordController.addListener(() {
      ref.read(loginPasswordProvider.notifier).update(
            (state) => state = _passwordController.text,
          );
    });
    _emailController.addListener(() {
      ref.read(loginEmailProvider.notifier).update(
            (state) => state = _emailController.text,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ScrollColumnExpandable(
        padding: EdgeInsets.zero,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 6,
          ),
          CustomTextFormField(
            prefixIcon: const Icon(Icons.person_outline_rounded),
            textCapitalization: TextCapitalization.none,
            controller: _emailController,
            hintText: 'Nombre de usuario',
            labelText: 'Ingrese su nombre de usuario',
            validator: AppValidations.notEmptyFieldValidation,
            fillColor: Colors.white,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomPasswordFormField(
            controller: _passwordController,
            labelText: 'Contraseña',
            hintText: 'Ingrese su contraseña',
            validator: AppValidations.validatePassword,
            fillColor: Colors.white,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButtonWithState(
            width: 230,
            adaptiveTextColor: true,
            enabled: (ref.watch(loginEmailProvider) ?? '').isNotEmpty &&
                (ref.watch(loginPasswordProvider) ?? '').isNotEmpty,
            text: 'Iniciar sesión',
            onTap: () async {
              if (_formKey.currentState?.validate() ?? false) {
                try {
                  await ref.read(userRepository).userLogin(
                        UserLoginDTO(
                          username: ref.read(loginEmailProvider) ??
                              _emailController.text,
                          password: ref.read(loginPasswordProvider) ??
                              _passwordController.text,
                        ),
                      );
                  Navigation.goTo(
                    CustomAppRouter.home,
                    context,
                    removeUntil: true,
                  );
                } catch (e) {
                  AppDialogs.genericConfirmationDialog(
                    title: 'Credenciales erróneas',
                    message: 'Revisa tus credenciales',
                    buttonText: 'Aceptar',
                    onTap: () {
                      Navigation.goBack(context);
                    },
                  );
                }
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
