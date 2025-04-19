import 'package:api_archi_bloc/config/routes/routes_name.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: (){
              Navigator.pushNamed(context, RoutesName.loginScreen);
            }, child:Text("go to Login")),
            Center(child: Text("This is splash screen")),
          ],
        ),
    );
  }
}