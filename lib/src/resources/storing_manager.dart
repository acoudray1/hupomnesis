import 'package:shared_preferences/shared_preferences.dart';

///
/// This class is used to interact with shared preferences package in order 
/// to store locally data and get them
/// 
class StoringManager {

  StoringManager();

  SharedPreferences prefs;


  Future<void>saveUser(String name) async {
    prefs = await SharedPreferences.getInstance();

    prefs.setString('user_name', name);
  }

  Future<String> getUserName() async {
    prefs = await SharedPreferences.getInstance();

    return prefs.getString('user_name') ?? 'default';
  }
}

StoringManager data = StoringManager();