
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  
  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  } 

}