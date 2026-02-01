import 'package:flutter/material.dart';
import 'package:practice_class/model/Setting.dart';
import 'package:practice_class/services/shared_preferences_service.dart';

class SharedPreferencesProvider extends ChangeNotifier {
 final SharedPreferencesService _service;
 
 SharedPreferencesProvider(this._service);
 
 String _message = "";
 String get message => _message;
 
 Setting? _setting;
 Setting? get setting => _setting;
 
 Future<void> saveSettingValue(Setting value) async {
   try {
     await _service.saveSettingValue(value);
     _message = "Your data is saved";
   } catch (e) {
     _message = "Failed to save your data";
   }
   notifyListeners();
 }
 
 void getSettingValue() async {
   try {
     _setting = _service.getSettingValue();
     _message = "Data successfully retrieved";
   } catch (e) {
     _message = "Failed to get your data";
   }
   notifyListeners();
 }
}