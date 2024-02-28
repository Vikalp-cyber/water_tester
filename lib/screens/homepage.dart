import 'dart:async';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart'; // Import flutter_blue
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
// import 'package:rive/rive.dart';
// import 'package:water_tester/utils/colors.dart';
import 'package:water_tester/utils/responsive_size.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDarkMode = false; // Track current mode
  bool isBluetoothOn = false; // Track Bluetooth status
  bool isTestingWaterQuality = false; // Track if water quality is being tested
  late Timer _timer; // Timer for the animation
  List<int> ph = [7, 5, 7, 8, 4, 9];
  List<int> temperature = [20, 19, 21, 28, 18, 10];
  List<int> percent = [90, 88, 91, 92, 93, 94];
  List<double> turbidity = [0.4, 1, 3, 2, 5, 10];
  List<int> tds = [200, 100, 300, 400, 500, 350];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize flutter_blue
    FlutterBlue.instance.state.listen((state) {
      setState(() {
        isBluetoothOn = state == BluetoothState.on;
      });
    });
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        // Increment currentIndex and ensure it stays within bounds
        currentIndex = (currentIndex + 1) % ph.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the animation timer when disposing the widget
    super.dispose();
  }

  void _startAnimation() {
    // Start a timer for 10 seconds
    _timer = Timer(const Duration(seconds: 4), () {
      setState(() {
        isTestingWaterQuality = false; // Testing completed
      });
      // Perform any action for displaying temperature here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: Image.asset(
            "assets/images/background.jpg",
            fit: BoxFit.cover,
          ),
        ),
        !isBluetoothOn
            ? Container(
                child: Column(
                  children: [
                    LottieBuilder.asset("assets/animation/bluetooth.json"),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Bluetooth is off, Please turn it on to proceed..",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40, left: 20),
                    child: const Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      "${percent[currentIndex]}%",
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text("Water Quality"),
                  ),
                  Wrap(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: ResponsiveSize.width(context, 0.04),
                            top: 20,
                            right: ResponsiveSize.width(context, 0.04)),
                        width: ResponsiveSize.width(context, 0.4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 5, // Spread radius
                              blurRadius: 7, // Blur radius
                              offset: const Offset(
                                  0, 3), // Offset in the x and y directions
                            ),
                          ],
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10,
                              left: ResponsiveSize.width(context, 0.04),
                              right: ResponsiveSize.width(context, 0.04),
                              bottom: 20),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.thermostat_sharp,
                                color: Colors.black,
                                size: 40,
                              ),
                              Text(
                                "${temperature[currentIndex]}C",
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text("Tempreture")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ResponsiveSize.width(context, 0.04),
                            top: 20,
                            right: ResponsiveSize.width(context, 0.04)),
                        width: ResponsiveSize.width(context, 0.4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 5, // Spread radius
                              blurRadius: 7, // Blur radius
                              offset: const Offset(
                                  0, 3), // Offset in the x and y directions
                            ),
                          ],
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10,
                              left: ResponsiveSize.width(context, 0.04),
                              right: ResponsiveSize.width(context, 0.04),
                              bottom: 20),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.thermostat_sharp,
                                color: Colors.black,
                                size: 40,
                              ),
                              Text(
                                "${ph[currentIndex]}",
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text("pH Scale")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ResponsiveSize.width(context, 0.04),
                            top: 20,
                            right: ResponsiveSize.width(context, 0.04)),
                        width: ResponsiveSize.width(context, 0.4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 5, // Spread radius
                              blurRadius: 7, // Blur radius
                              offset: const Offset(
                                  0, 3), // Offset in the x and y directions
                            ),
                          ],
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 20, right: 20, bottom: 20),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.cloud,
                                color: Colors.black,
                                size: 40,
                              ),
                              Text(
                                "${turbidity[currentIndex]}",
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text("Turbidity")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 20, top: 20, right: 20),
                        width: ResponsiveSize.width(context, 0.4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 5, // Spread radius
                              blurRadius: 7, // Blur radius
                              offset: const Offset(
                                  0, 3), // Offset in the x and y directions
                            ),
                          ],
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 20, right: 20, bottom: 20),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.thermostat_sharp,
                                color: Colors.black,
                                size: 40,
                              ),
                              Text(
                                "${tds[currentIndex]}",
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text("Total Dissolved Solid")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: ResponsiveSize.height(context, 0.1),
                          left: ResponsiveSize.width(context, 0.3)),
                      height: ResponsiveSize.height(context, 0.07),
                      width: ResponsiveSize.width(context, 0.4),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: () {},
                        child: const Text(
                          "Reload",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ],
    ));
  }
}
