import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('======== FCM Token =======');
      print(token);

      //fiaKmOQ2AhE:APA91bEywlGDROwBHLOqMbeNNZjsM_EKrb_GvNSD2FnApB320F_p7laIFLswW4zbW9ux7AaEd7W82PLQpUIPaJWsTRIeZMV9lBDtLrR2NWqeeV1IrzcY6Mi1Z86dx6d5Fpqr53BVif-T
    });

    _firebaseMessaging.configure(onMessage: (info) async {
      print('============ On Message ===============');
      print(info);

      String argumento = 'no-data';
      if (Platform.isAndroid) {
        argumento = info['data']['comida'] ?? 'no-data';
      }
      _mensajesStreamController.sink.add(argumento);
    }, onLaunch: (info) async {
      print('============ On Launch ===============');
      print(info);
      
      String argumento = 'no-data';
      if (Platform.isAndroid) {
        argumento = info['data']['comida'] ?? 'no-data';
      }
      _mensajesStreamController.sink.add(argumento);
    }, onResume: (info) async {
      print('============ On Resume ===============');
      print(info);
      final noti = info['data']['comida'];
      print(noti);
      _mensajesStreamController.sink.add(noti);
    });
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}
