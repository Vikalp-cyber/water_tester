import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:water_tester/screens/homepage.dart';
import 'package:water_tester/screens/services.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({super.key});

  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  String? selectedDevice;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(31, 44, 44, 44).withOpacity(0.5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LottieBuilder.asset("assets/animation/bluetooth.json"),
            DropdownButton<String>(
              value: selectedDevice,
              style: const TextStyle(color: Colors.white),

              dropdownColor: Colors.grey.shade800, // Set dropdown color
              borderRadius: BorderRadius.circular(20),
              onChanged: (String? newValue) {
                setState(() {
                  selectedDevice = newValue;
                });
              },
              items: <String>[
                'Device 1',
                'Device 2',
                'Device 3',
                'Device 4',
                'Device 5'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: const TextStyle(
                          color: Colors.white)), // Set text color
                );
              }).toList(),
              selectedItemBuilder: (BuildContext context) {
                return <String>[
                  'Device 1',
                  'Device 2',
                  'Device 3',
                  'Device 4',
                  'Device 5'
                ].map<Widget>((String value) {
                  return Text(
                    value,
                    style: const TextStyle(
                        color: Colors.white), // Set selected item text color
                  );
                }).toList();
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedDevice != null) {
                  // Navigate to the home page with selected device
                  final device = Provider.of<Device>(context,listen: false);
                  device.updateDevice();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ),
                  );
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
