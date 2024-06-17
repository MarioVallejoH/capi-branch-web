import 'package:flutter/material.dart';
import 'package:web/src/config/config.dart';

/// Generic back arrow button with customizable color and size
class CloseIconButton extends StatelessWidget {
  /// Widget constructor
  const CloseIconButton({
    super.key,
    this.size = 22,
    this.backgroundColor,
    this.color,
    this.onTap,
  });

  /// Icons size
  final double size;

  /// Icon color
  final Color? color;

  /// Background color
  final Color? backgroundColor;

  /// Button callback
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primary_200,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(
          Icons.close_rounded,
          color: color ?? AppColors.secondary_500,
          size: size,
        ),
      ),
    );
  }
}
