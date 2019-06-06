import 'package:hupomnesis/src/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// This class is used to interact with shared preferences package in order 
/// to store locally data and get them
/// 
class StoringManager {

  StoringManager();

  SharedPreferences prefs;
  
  ///
  /// Check what is the initial theme 
  /// 
  Future<bool> isThemeDark() async {
    prefs = await SharedPreferences.getInstance();

    return prefs.getBool('isDark') ?? false;
  }

  ///
  /// Toggle the actual theme
  /// 
  Future<void> toggleTheme() async {
    prefs = await SharedPreferences.getInstance();

    final bool isDark = prefs.getBool('isDark') ?? false;

    if(isDark)
      prefs.setBool('isDark', false);
    else
      prefs.setBool('isDark', true);
  }
}

// We create a singleton for the app
StoringManager data = StoringManager();