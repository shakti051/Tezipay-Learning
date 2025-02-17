import 'dart:convert';

import 'package:demo_challenge_code/api/dashboard_screen.dart';
import 'package:demo_challenge_code/api/get_server_key.dart';
import 'package:demo_challenge_code/api/notification_screen.dart';
import 'package:demo_challenge_code/api/notification_services.dart';
import 'package:demo_challenge_code/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


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
        onTap: () async {
         
        //  Navigator.pushNamed(context, '/dashboard-screen');
        // ?.pushNamed(NotificationScreen.route, arguments: "hiiiiiiiiiiii");
        // navigatorKey.currentState
        // ?.pushNamed(DashboardScreen.route);
        GetServerKey getServerKey = GetServerKey();
        String accessToken = await getServerKey.getServerKeyToken();
        debugPrint("Server key $accessToken");

        await notificationServices.getDeviceToken().then((value){
             var data = {
              'priority': "high",
              'to' : value.toString(),
              'notification' : {
                'title' : 'Leave Request' ,
                'body' : 'Your leave request has been approved' ,
                
            },
              'android': {
                'notification': {
                  'notification_count': 23,
                },
              },
              'data' : {
                'numOne' : 34 ,
                'numTwo' : 12,
                'numThree':67
              }
            };
             http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),body: jsonEncode(data),
             headers: {
              'Content-Type': 'application/json; charset=UTF-8',
                'Authorization' : accessToken   
             }
             ); 
          });
        },
        child: Center(
          child: Text("Home Page",style: TextStyle(fontSize: 24),),
        ),
      )),
    );
  }
}
