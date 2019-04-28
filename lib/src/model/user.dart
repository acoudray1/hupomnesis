///
/// This object represent a user that is currently active on the app
/// 
class User {

  User({
    this.name,
  });

  String name;
}

// We create a singleton for the app
User user = User();