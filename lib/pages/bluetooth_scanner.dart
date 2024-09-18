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
                color: Colors.blue,
                child: const Center(
                  child: Text("SCANNER"),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                  child: ElevatedButton(
                onPressed: () {
                  controller.scanDevices();
                },
                child: Text("Scan"),
              )),
              const SizedBox(height: 20),
              StreamBuilder<List<ScanResult>>(
                  stream: FlutterBluePlus.scanResults,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      print(snapshot.data);
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          print(data);
                          return Card(
                            child: ListTile(
                              title: Text(data.device.platformName),
                              subtitle: Text(data.device.advName),
                              trailing: Text(data.rssi.toString()),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("no devices found"),
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
