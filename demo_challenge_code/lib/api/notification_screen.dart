import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static const route = '/notification-screen';
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      appBar: AppBar(title: Text("Push Notifications")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message.notification!.title!,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              message.notification!.body!,
              style: TextStyle(fontSize: 18),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50), // Makes it circular
                  ),
                  elevation: 5, // Adds shadow
                  child: Container(
                    width: 100, // Width of circular card
                    height: 100, // Height of circular card
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Ensures it's circular
                      color: Colors.blue, // Card color
                    ),
                    child: Text(
                      message.data["numOne"] ?? "00",
                      style: TextStyle(fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),
                    ), // Example content
                  ),
                ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), // Makes it circular
              ),
              elevation: 5, // Adds shadow
              child: Container(
                width: 100, // Width of circular card
                height: 100, // Height of circular card
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Ensures it's circular
                  color: Colors.blue, // Card color
                ),
                child: Text(
                  message.data["numTwo"] ?? "00",
                  style: TextStyle(fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),
                ), // Example content
              ),
            ),  
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), // Makes it circular
              ),
              elevation: 5, // Adds shadow
              child: Container(
                width: 100, // Width of circular card
                height: 100, // Height of circular card
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Ensures it's circular
                  color: Colors.blue, // Card color
                ),
                child: Text(
                  message.data["numThree"] ?? "00",
                  style: TextStyle(fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),
                ), // Example content
              ),
            ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
