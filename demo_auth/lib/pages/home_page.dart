import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePagwState();
}

class _HomePagwState extends State<HomePage> {
  bool isAuthenticated = false;
  final LocalAuthentication auth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
      floatingActionButton: _authButton(),
      //body: Center(child: Text("Home page")),
    );
  }

  Widget _authButton() {
    return FloatingActionButton(
        child: Icon(isAuthenticated ? Icons.lock : Icons.lock_open),
        onPressed: () async{
          if(!isAuthenticated) {
            try{
               final bool canAuthenticateBiometric = await auth.canCheckBiometrics;
              debugPrint(canAuthenticateBiometric.toString());
              if(canAuthenticateBiometric){
                final bool didAuthenticate = await auth.authenticate(localizedReason: "Please authenticate to show bank balance",
                options: AuthenticationOptions(biometricOnly: false)
                );
                setState(() {
                  isAuthenticated = didAuthenticate;
                });
              } 
            }catch(e){
              debugPrint(e.toString());
            }
             
          }else{
          setState(() {
            isAuthenticated = false;
          
          });
          }
          // setState(() {
          //   isAuthenticated = !isAuthenticated;
          // });
        });
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Account Balance",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          if (isAuthenticated)
            Text(
              "\$ 25,455",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          if (!isAuthenticated)
            Text(
              "******",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
