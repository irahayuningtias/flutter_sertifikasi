import 'package:flutter/foundation.dart';
import 'package:flutter_sertifikasi/models/user.dart';
import 'package:flutter_sertifikasi/helper/dbhelper.dart'; 

class UserProvider extends ChangeNotifier {
  User? _user;
  final DbHelper dbHelper = DbHelper();

  User? get user => _user;

  Future<void> fetchUserByEmail(String email) async {
    final user = await dbHelper.getUserByEmail(email);
    if (user != null) {
      _user = user;
      notifyListeners();
    }
  }
}
