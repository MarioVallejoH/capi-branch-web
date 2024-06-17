import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web/src/config/config.dart';

/// Custom TexFormField used commonly on app
class CustomPasswordFormField extends StatelessWidget {
  /// Constructor
  CustomPasswordFormField({
    super.key,
    this.fillColor = Colors.white,
    this.validator,
    this.hintText,
    this.labelText,
    this.label,
    this.controller,
    this.initialValue,
    this.maxLength,
    this.showRequiredIndicator = false,
    this.onChanged,
  });

  /// TextFormField validation function
  final String? Function(String?)? validator;

  /// TextFormField label text
  final String? labelText;

  /// TextFormField label text
  final Widget? label;

  /// TextFormField hint text
  final String? hintText;

  /// TextFormField initial value, if specified then controller won't will be assign
  /// to TextFromField
  final String? initialValue;

  /// TextFormField controller, if specified then initial value won't will be assign
  /// to TextFromField
  final TextEditingController? controller;

  /// Max No of characters
  final int? maxLength;

  final ValueNotifier<bool> _showPassword = ValueNotifier(true);

  /// To show or not required indicator
  final bool showRequiredIndicator;

  /// Input fill color
  final Color fillColor;

  ///
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _showPassword,
      child: SvgPicture.asset(
        'assets/svg/eye.svg',
        height: 24,
        width: 24,
      ),
      builder: (BuildContext context, bool value, Widget? child) {
        return CustomTextFormField(
          onChanged: onChanged,
          prefixIcon: const Icon(Icons.vpn_key_outlined),
          fillColor: fillColor,
          controller: controller,
          validator: validator,
          showRequiredIndicator: showRequiredIndicator,
          hintText: hintText,
          maxLength: maxLength,
          minLines: null,
          maxLines: 1,
          keyboardType: TextInputType.visiblePassword,
          obscureText: value,
          labelText: labelText,
          suffixIcon: InkWell(
            borderRadius: BorderRadius.circular(100),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 9,
              ),
              child: !value
                  ? child
                  : SvgPicture.asset(
                      'assets/svg/eye_closed.svg',
                      height: 24,
                      width: 24,
                    ),
            ),
            onTap: () {
              _showPassword.value = !value;
            },
          ),
        );
      },
    );
  }
}

/// Custom TexFormField used commonly on app
class CustomTextFormField extends StatelessWidget {
  /// Constructor
  const CustomTextFormField({
    super.key,
    this.validator,
    this.hintText,
    this.labelText,
    this.controller,
    this.onSubmit,
    this.initialValue,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.obscureText,
    this.suffixIcon,
    this.textCapitalization,
    this.keyboardType,
    this.prefixIcon,
    this.enabled = true,
    this.label,
    this.fillColor = Colors.white,
    this.showRequiredIndicator = false,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.onChanged,
    this.onTap,
    this.focusNode,
  });

  ///
  final FloatingLabelBehavior floatingLabelBehavior;

  /// TextFormField validation function
  final String? Function(String?)? validator;

  /// TextFormField label text
  final String? labelText;

  /// TextFormField hint text
  final String? hintText;

  ///
  final FocusNode? focusNode;

  /// TextFormField initial value, if specified then controller won't will be assign
  /// to TextFromField
  final String? initialValue;

  /// To show or not required indicator
  final bool showRequiredIndicator;

  /// TextFormField controller, if specified then initial value won't will be assign
  /// to TextFromField
  final TextEditingController? controller;

  /// Min lines to show on TextFormField
  final int? minLines;

  /// Max Lines on TextFormField, it will resize to the current No of lines if < maxLines
  final int? maxLines;

  /// Max No of characters
  final int? maxLength;

  /// Hide or show text
  final bool? obscureText;

  /// Optional text capitalization, by default [TextCapitalization.words]
  final TextCapitalization? textCapitalization;

  /// Suffix widget
  final Widget? suffixIcon;

  /// Prefix widget
  final Widget? prefixIcon;

  /// Label widget
  final Widget? label;

  /// TextFromField keyboard type
  final TextInputType? keyboardType;

  /// To enable or disable field
  final bool enabled;

  /// Input fill color
  final Color fillColor;

  ///
  final Function(String?)? onChanged;

  ///
  final Function(String?)? onSubmit;

  ///
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      focusNode: focusNode,
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      onTapOutside: (_) {
        focusNode?.unfocus();
      },
      style: theme.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      enabled: enabled,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      validator: validator,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      obscureText: obscureText ?? false,
      textCapitalization: textCapitalization ?? TextCapitalization.words,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: true,
        floatingLabelBehavior: floatingLabelBehavior,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        labelStyle: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: enabled ? AppColors.secondary_500 : AppColors.secondary_300,
        ),
        errorStyle: theme.textTheme.bodyMedium?.copyWith(
          color: AppColors.danger_700,
          fontWeight: FontWeight.w500,
        ),
        labelText: showRequiredIndicator ? null : labelText,
        label: showRequiredIndicator
            ? (label ??
                (labelText != null
                    ? LabelRequired(
                        label: labelText!,
                        required: showRequiredIndicator,
                      )
                    : null))
            : null,
      ),
    );
  }
}

/// Label for required TextFormFields
class LabelRequired extends StatelessWidget {
  /// Widget constructor
  const LabelRequired({
    super.key,
    required this.label,
    this.required = true,
  });

  /// Label text
  final String label;

  /// Add required indicator
  final bool required;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyLarge;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: textStyle?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          if (required)
            TextSpan(
              text: '*',
              style: textStyle?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.error,
              ),
            ),
        ],
      ),
    );
  }
}
