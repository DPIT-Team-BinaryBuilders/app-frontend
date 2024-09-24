import 'package:get/get.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';

class BleController extends GetxController {
  FlutterBluePlus flutterBlue = FlutterBluePlus();
  late BluetoothDevice connectedDevice;

  Future<void> scanDevices() async {
    if (await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted &&
        await Permission.location.request().isGranted) {
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));

      await Future.delayed(const Duration(seconds: 15));
      FlutterBluePlus.stopScan();
    }
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  Future<void> connectToDevice(BluetoothDevice device) async {
    await device?.connect(timeout: const Duration(seconds: 15));
    connectedDevice = device;
    discoverServices(device);

    // device.connectionState.listen((isConnected) {
    //   if (isConnected == BluetoothConnectionState.connected) {
    //     print('device connected ${device.platformName}');
    //   } else {
    //     print('device disconnected');
    //   }
    //   ;
    // });
  }

  void discoverServices(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      //function used to find the write data path(UUID) for bluetooth device
      // for (BluetoothCharacteristic characteristic in service.characteristics) {
      //   print('Found characteristic: ${characteristic.uuid}');
      // }
    });
  }

  Future <void> sendData(BluetoothDevice device, String message) async {
    List<BluetoothService> services = await device.discoverServices();

    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.properties.write) {
          await characteristic.write(utf8.encode(message));
          print("Sent: $message");
        }
      }
    }
  }
}
