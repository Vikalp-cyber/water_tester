import 'dart:async';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:water_tester/customPainter.dart';
import 'package:water_tester/screens/deviceList.dart';
import 'package:water_tester/screens/graph.dart';
import 'package:water_tester/screens/home.dart';
import 'package:water_tester/screens/services.dart';
import 'package:water_tester/screens/setting.dart';
import 'package:water_tester/utils/responsive_size.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDarkMode = false;
  bool isBluetoothOn = false;
  bool isTestingWaterQuality = false;
  late Timer _timer;
  List<int> ph = [7, 5, 7, 8, 4, 9];
  List<int> temperature = [20, 19, 21, 28, 18, 10];
  List<double> percent = [90.00, 88.00, 91.00, 92.00, 93.00, 94.00];
  List<double> turbidity = [0.4, 1, 3, 2, 5, 10];
  List<int> tds = [200, 100, 300, 400, 500, 350];
  int currentIndex = 0;
  int page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> _screens = [const Graph(), const Home(), const Setting()];
  @override
  void initState() {
    super.initState();
    final device = Provider.of<Device>(context, listen: false);
    FlutterBlue.instance.state.listen((state) {
      setState(() {
        isBluetoothOn = state == BluetoothState.on;
        if (isBluetoothOn && device.IsDeviceSelected == false) {
          // If Bluetooth is turned on, navigate to the list of dummy devices
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DeviceList()),
          );
        }
      });
    });
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % ph.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startAnimation() {
    _timer = Timer(const Duration(seconds: 4), () {
      setState(() {
        isTestingWaterQuality = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(250, 27, 30, 60).withOpacity(0.5),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(250, 27, 30, 60).withOpacity(0.5),
        title: const Text(
          "Water Quality Tester",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'lora',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: !isBluetoothOn
          ? Container(
              child: Column(
                children: [
                  SizedBox(
                    height: ResponsiveSize.height(context, 0.6),
                    child: LottieBuilder.asset(
                        "assets/animation/water_testing.json"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      margin: EdgeInsets.only(
                        left: ResponsiveSize.width(context, 0.05),
                        right: ResponsiveSize.width(context, 0.05),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: ResponsiveSize.height(context, 0.05),
                              child: SvgPicture.asset(
                                "assets/icons/error.svg",
                                color: Colors.red,
                              ),
                            ),
                            const Text(
                              "Bluetooth is off, Please turn it on to proceed..",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'lora',
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : _screens[page],
      bottomNavigationBar: !isBluetoothOn
          ? null
          : CurvedNavigationBar(
              key: _bottomNavigationKey,
              items: const [
                CurvedNavigationBarItem(
                    child: Icon(Icons.auto_graph_rounded), label: 'Graph'),
                CurvedNavigationBarItem(child: Icon(Icons.home), label: 'Home'),
                CurvedNavigationBarItem(
                    child: Icon((Icons.settings)), label: 'Settings'),
              ],
              color: Colors.white,
              backgroundColor: const Color.fromARGB(255, 33, 54, 243),
              animationDuration: const Duration(milliseconds: 700),
              index: 0,
              onTap: (index) {
                // Handle bottom navigation item tap
                setState(() {
                  page = index;
                });
              },
            ),
    );
  }
}
