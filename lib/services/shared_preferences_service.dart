import 'package:practice_class/model/Setting.dart';
import 'package:practice_class/utils/page_size_number.dart';
import 'package:shared_preferences/shared_preferences.dart';
  
class SharedPreferencesService {
  final SharedPreferences _preferences;
  SharedPreferencesService(this._preferences);
 
  static const String _keyNotification = "MY_NOTIFICATION";
  static const String _keyPageNumber = "MY_PAGE_NUMBER";
  static const String _keySignature = "MY_SIGNATURE";
 
  Future<void> saveSettingValue(Setting setting) async {
    try {
      await _preferences.setBool(_keyNotification, setting.notificationEnabled);
      await _preferences.setInt(_keyPageNumber, setting.pageNumber);
      await _preferences.setString(_keySignature, setting.signature);
    } catch (e) {
      throw Exception("Shared preferences cannot save the setting value.");
    }
  }
 
  Setting getSettingValue() {
    return Setting(
      notificationEnabled: _preferences.getBool(_keyNotification) ?? true,
      pageNumber: _preferences.getInt(_keyPageNumber) ?? defaultPageSizeNumbers,
      signature: _preferences.getString(_keySignature) ?? "",
    );
  }
}