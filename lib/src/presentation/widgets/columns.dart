import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:web/src/utils/utils.dart';

/// Generic column with padding attribute
///
/// By default takes app bodyDefaultPadding
class ColumnWithPadding extends StatelessWidget {
  /// Widget constructor
  const ColumnWithPadding({
    super.key,
    this.padding,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
  });

  /// Padding to use on widget
  final EdgeInsets? padding;

  /// List of Colum children
  final List<Widget> children;

  /// Column [CrossAxisAlignment] property
  final CrossAxisAlignment crossAxisAlignment;

  /// Column [MainAxisAlignment] property
  final MainAxisAlignment mainAxisAlignment;

  /// Column [MainAxisSize] property
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    final responsive = GetIt.instance.get<ResponsiveDesign>();

    return Padding(
      padding: padding ?? responsive.appHorizontalPadding,
      child: Column(
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: children,
      ),
    );
  }
}
