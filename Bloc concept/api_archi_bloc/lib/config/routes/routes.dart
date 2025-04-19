import 'package:api_archi_bloc/config/routes/routes_name.dart';
import 'package:api_archi_bloc/home/home_screen.dart';
import 'package:api_archi_bloc/login/login_screen.dart';
import 'package:api_archi_bloc/main.dart';
import 'package:api_archi_bloc/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
      return MaterialPageRoute(builder: (context)=> SplashScreen());
      case RoutesName.loginScreen:
      return MaterialPageRoute(builder: (context)=> LoginScreen());
      case RoutesName.homeScreen:
      return MaterialPageRoute(builder: (context)=> HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(body: Center(child: Text("No route found")));
          },
        );
    }
  }
}
