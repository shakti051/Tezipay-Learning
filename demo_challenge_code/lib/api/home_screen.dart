import 'package:demo_challenge_code/api/dashboard_screen.dart';
import 'package:demo_challenge_code/api/notification_screen.dart';
import 'package:demo_challenge_code/api/notification_services.dart';
import 'package:demo_challenge_code/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
     notificationServices.getDeviceToken().then((value){
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Push Notifications")),
      body: Container(
          child: GestureDetector(
        onTap: () {
        //  Navigator.pushNamed(context, '/dashboard-screen');
          // ?.pushNamed(NotificationScreen.route, arguments: "hiiiiiiiiiiii");
        navigatorKey.currentState
        ?.pushNamed(DashboardScreen.route);
        },
        child: Center(
          child: Text("Home Page",style: TextStyle(fontSize: 24),),
        ),
      )),
    );
  }
}
