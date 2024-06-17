import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web/src/data/repositories/user_repository.dart';
import 'package:web/src/domain/dtos/dtos.dart';
import 'package:web/src/presentation/state/registration_form.dart';
import 'package:web/src/presentation/widgets/scroll_column_expandable.dart';
import 'package:web/src/presentation/widgets/widgets.dart';
import 'package:web/src/utils/utils.dart';

/// User registrationEmailProvider form
class RegistrationForm extends ConsumerStatefulWidget {
  /// Constructor
  const RegistrationForm({super.key});

  @override
  ConsumerState<RegistrationForm> createState() => RegistrationFormState();
}

class RegistrationFormState extends ConsumerState<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _passwordController.addListener(() {
      ref.read(registrationPasswordProvider.notifier).update(
            (state) => state = _passwordController.text,
          );
    });
    _emailController.addListener(() {
      ref.read(registrationEmailProvider.notifier).update(
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
            enabled: (ref.watch(registrationEmailProvider) ?? '').isNotEmpty &&
                (ref.watch(registrationPasswordProvider) ?? '').isNotEmpty,
            text: 'Registrarme',
            onTap: () async {
              if (_formKey.currentState?.validate() ?? false) {
                try {
                  await ref.read(userRepository).userRegister(
                        RegisterDTO(
                          username: ref.read(registrationEmailProvider) ??
                              _emailController.text,
                          password: ref.read(registrationPasswordProvider) ??
                              _passwordController.text,
                        ),
                      );
                  Navigation.goBack(context);
                } catch (e) {
                  AppDialogs.genericConfirmationDialog(
                    title: 'Error al registrar el usuario',
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
