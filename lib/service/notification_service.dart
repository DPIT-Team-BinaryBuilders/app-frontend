import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:safetybuddy/controller/bluetoothController.dart';
import 'package:permission_handler/permission_handler.dart';

getUserLocation() async {
  String userLocation;
  Position position = await Geolocator.getCurrentPosition();
  userLocation = "${position.latitude},${position.longitude}";
  return userLocation;
}

Future<void> requestNotificationPermission() async {
  // Check current notification permission status
  PermissionStatus status = await Permission.notification.status;

  if (status.isDenied) {
    // If the permission is denied, request it from the user
    PermissionStatus result = await Permission.notification.request();

    if (result.isGranted) {
      print('Notification permission granted');
    } else if (result.isDenied) {
      print('Notification permission denied');
    } else if (result.isPermanentlyDenied) {
      print(
          'Notification permission permanently denied. Go to settings to enable.');
      // Open app settings to allow the user to manually enable the permission
      openAppSettings();
    }
  } else if (status.isGranted) {
    print('Notification permission already granted');
  }
}

checkLocationStatus(userLocation) async {
  Dio dio = Dio();
  String _apiUrl = "de completat";
  final BleController bleController = Get.put(BleController());

  Map<String, dynamic> data = {userLocation: getUserLocation()};
  final response = await dio.post(_apiUrl, data: data);

  if (response.statusCode == 200) {
    bool responseData = response.data;
    bool notification = responseData;
    if (notification) {
      //notif send condittion
      if (BluetoothConnectionState.connected == true) {
        // Sends DangerZone to watch
        print("trimit activare ceas");
        var device = bleController.connectedDevice;
        bleController.sendData(device!, "DangerZone");
      }
      sendNotification();
    }
  }
}

sendNotification() {
  print('intrat in send notif');
  requestNotificationPermission();
  AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Near a danger zone',
        body: 'Head back'),
  );
}
