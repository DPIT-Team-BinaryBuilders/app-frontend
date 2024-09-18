import 'package:get/get.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BleController extends GetxController {
  FlutterBluePlus flutterBlue = FlutterBluePlus();

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
    try {
      await device.connect();
      print('Connected to device: ${device.name}');
    } catch (e) {
      print('Failed to connect: $e');
    }
  }
}
