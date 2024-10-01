import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:safetybuddy/controller/bluetoothController.dart';

class BleScanner extends StatefulWidget {
  const BleScanner({super.key});

  @override
  State<BleScanner> createState() => _BleScannerState();
}

class _BleScannerState extends State<BleScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<BleController>(
      init: BleController(),
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 180,
                color: Color.fromARGB(255, 255, 137, 137),
                child: const Center(
                  child: Text(
                    "Bluetooth",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                  child: ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 137, 137),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  controller.scanDevices();
                },
                child: Text(
                  "Scan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              )),
              const SizedBox(height: 20),
              StreamBuilder<List<ScanResult>>(
                  stream: FlutterBluePlus.scanResults,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      //print(snapshot.data);
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          //  print(data);
                          return Card(
                            child: ListTile(
                              title: Text(data.device.platformName),
                              subtitle: Text(data.device.advName),
                              trailing: Text(data.rssi.toString()),
                              onTap: () {
                                controller.connectToDevice(data.device);
                                final BleController bleController =
                                    Get.put(BleController());
                                if (bleController.connectionState ==
                                    BluetoothConnectionState.connected) {
                                  AwesomeNotifications().createNotification(
                                      content: NotificationContent(
                                          id: 11,
                                          channelKey: 'basic_channel',
                                          title: 'Device connected',
                                          body: 'Successfully'));
                                }
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(""),
                      );
                    }
                  })
            ],
          ),
        );
      },
    ));
  }
}
