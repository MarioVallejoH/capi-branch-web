import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:web/src/utils/responsive.dart';

/// App global Lazy singletons locator
class GlobalLocator {
  /// Responsive design class with useful methods to perform
  /// responsive design
  static ResponsiveDesign get responsiveDesign =>
      GetIt.instance.get<ResponsiveDesign>();

  /// Global app logger instance
  static Logger get appLogger => GetIt.instance.get<Logger>();
}
