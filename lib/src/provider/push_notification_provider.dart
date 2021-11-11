import 'dart:convert';


import 'package:delivery/src/models/user.dart';
import 'package:delivery/src/provider/user_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class PushNotificationProvider{

  AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void initNotification() async{
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void onMensageLisent(){
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage message) {
    if (message != null) {
      print('Nueva Notifficacion: ${message}');
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ));
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    /*Navigator.pushNamed(context, '/message',
        arguments: MessageArguments(message, true));*/
  });
}

void saveToken(Users users,BuildContext context) async{
  String token = await FirebaseMessaging.instance.getToken();
  UserProvider userProvider = new UserProvider();
  userProvider.init(context,sessionuser: users);
  userProvider.updateToken(users.id, token);

}

Future<void> sendMesage(String to,Map<String, dynamic> data,String title,String body) async{
  Uri uri = Uri.https('fcm.googleapis.com', '/fcm/send');
  await http.post(uri,
  headers: <String, String>{
    'Content-Type':'application/json',
    'Authorization': 'key=AAAAVgcCG2A:APA91bGWumPrfrC0cvYWaBPSrjhfrU6CwKnpBbBjIOZPcty412ujggLi1s9_2ASzOM9ktRwsFkwzaaj5riPUb84z2JS-lWQ8D10ppkd9R8cdt_SLnJ3TA9OMITlDB78AIhNAZueRTKOW',

  },
    body: jsonEncode(<String, dynamic>{
      'notification':<String, dynamic>{
        'body': body,
        'title': title,

      },
      'priority':'high',
      'ttl':'4500s',
      'data': data,
      'to': to

    })
  );

}

}