import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StreamProvider<User?>(
  (ref) {
    return FirebaseAuth.instance.authStateChanges();
  },
);

class AuthProvider {
  static Future<User?> registration({
    required String email,
    required String password,
  }) async {
    try {
      EasyLoading.show(status: "Registering...");
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      EasyLoading.dismiss();
      return userCredential.user;
    } catch (e) {
      EasyLoading.showError(e.toString());
      return null;
    }
  }

  static Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      EasyLoading.show(status: 'Logging in ...');
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      EasyLoading.dismiss();
      return userCredential.user;
    } catch (e) {
      EasyLoading.showError(e.toString());
      return null;
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
