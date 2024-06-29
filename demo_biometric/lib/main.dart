
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import '../pages/home_page.dart';

//https://www.flutteruidev.tech/tutorials/how-to-add-biometric-authentication-in-flutter
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
final LocalAuthentication _localAuth = LocalAuthentication();

//Check if biometric auth is available
Future<bool> hasBiometrics() async {
    //implemented
    try {
        return await _localAuth.canCheckBiometrics;
    } on PlatformException catch (e) {
        return false;
    }
}

//Authenticate using biometric
Future<bool> authenticate() async {
    final hasBiometric = await hasBiometrics();

    if(hasBiometric) {
        return await _localAuth.authenticate(
                localizedReason: "Scan fingerprint to authenticate",
                options: const AuthenticationOptions(
                    //Shows error dialog for system-related issues
                    useErrorDialogs: true,
                    //If true, auth dialog is show when app open from background
                    stickyAuth: true,
                    //Prevent non-biometric auth like such as pin, passcode.
                    biometricOnly: true,
                ),
        );
    } else {
        return false;
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: const Text('Login Screen')),
            body: Center(
                child: ElevatedButton(
                    onPressed: () async {
                        final isAuthenticated = await authenticate();

                        if(isAuthenticated) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => HomePage()),
                            );
                        } else {
                          print("Non Authorised");
                            // final snackbar = Snackbar(content: Text('Auth Failed'));
                            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                    },
                    child: const Text('Authenticate'),
                ),
            ),
        );
  }
}