import 'package:flutter/material.dart';
import 'package:web/src/config/config.dart';
import 'package:web/src/utils/responsive.dart';

/// Column with scroll properties, can manage expanded elements and can be
/// expanded.
class ScrollColumnExpandable extends StatelessWidget {
  /// Constructor
  const ScrollColumnExpandable({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.mainAxisAlignment,
    this.verticalDirection = VerticalDirection.down,
    this.padding,
    this.textDirection,
    this.textBaseline,
    this.physics,
    this.controller,
  });

  /// List of widgets to show vertically
  final List<Widget> children;

  /// CrossAxisAlignment property of Column widget
  final CrossAxisAlignment crossAxisAlignment;

  /// MainAxisAlignment property of Column widget
  final MainAxisAlignment mainAxisAlignment;

  /// VerticalDirection property of Column widget
  final VerticalDirection verticalDirection;

  /// TextDirection to use on Column Text widgets
  final TextDirection? textDirection;

  /// TextBaseLine to use on Text widgets
  final TextBaseline? textBaseline;

  /// Padding to apply on this widget
  final EdgeInsetsGeometry? padding;

  ///How the scroll view should respond to user input.
  final ScrollPhysics? physics;

  /// Scroll controller
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[const SizedBox(width: double.infinity)];
    final responsive = ResponsiveDesign(context);
    EdgeInsetsGeometry selectedPadding;
    if (padding == null) {
      selectedPadding = EdgeInsets.symmetric(
        horizontal: responsive.width(AppSizes.bodyDefaultHPadding),
      );
    } else {
      selectedPadding = padding!;
    }

    children.addAll(this.children);
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          controller: controller,
          physics: physics ?? const BouncingScrollPhysics(),
          child: Padding(
            padding: selectedPadding,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraint.maxHeight - selectedPadding.vertical,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: crossAxisAlignment,
                  mainAxisAlignment: mainAxisAlignment,
                  mainAxisSize: MainAxisSize.max,
                  verticalDirection: verticalDirection,
                  textBaseline: textBaseline,
                  textDirection: textDirection,
                  children: children,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
