import 'package:flutter/material.dart';
import 'package:task_app/screens/tabs_screen.dart';
import '../screens/recycle_bin.dart';
import '../screens/pending_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: (_) => const RecycleBin());
      case TabsScreen.id:
        return MaterialPageRoute(builder: (_) => TabsScreen());
      // case RegisterScreen.id:
      //   return MaterialPageRoute(
      //     builder: (_) => const RegisterScreen(),
      //   );
      // case LoginScreen.id:
      //   return MaterialPageRoute(
      //     builder: (_) => const LoginScreen(),
      //   );
      // case ForgotPasswordScreen.id:
      //   return MaterialPageRoute(
      //     builder: (_) => const ForgotPasswordScreen(),
      //   );
      default:
        return null;
    }
  }
}
