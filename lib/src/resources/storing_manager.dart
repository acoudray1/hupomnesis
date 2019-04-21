import 'package:hupomnesis/src/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// This class is used to interact with shared preferences package in order 
/// to store locally data and get them
/// 
class StoringManager {

  StoringManager();

  SharedPreferences prefs;

  // Save user's data locally
  Future<void> saveUser(String name) async {
    prefs = await SharedPreferences.getInstance();

    prefs.setString('user_name', name);
  }

  // add data from shared prefereces to User object
  // @return true if the user exists
  //         false if user hasn't been already initialized
  Future<bool> initializeUser() async {
    prefs = await SharedPreferences.getInstance();

    final String name = prefs.getString('user_name') ?? 'default';
    bool ret;

    if(name == 'default') {
      ret = false;
    } else {
      ret = true;
      user.name = name;
    }

    return ret;
  }

  Future<void> deleteUser() async {
    prefs = await SharedPreferences.getInstance();

    
  }
}

StoringManager data = StoringManager();