import 'package:flutter/material.dart';

class Device extends ChangeNotifier{
  bool IsDeviceSelected = false;
  void updateDevice(){
    IsDeviceSelected = true;
    notifyListeners();
  }
}