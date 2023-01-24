import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/constants/firebase_constants.dart';
import 'package:weather_app/models/profile_model.dart';
import 'package:weather_app/providers/auth_provider.dart';

final profileFutureProvider = FutureProvider<ProfileModel?>((ref) async {
  final collection =
      FirebaseFirestore.instance.collection(FirebaseConstants.userProfile);

  final currentUser = ref.read(currentUserProvider);

  if (currentUser != null) {
    return collection
        .where("id", isEqualTo: currentUser.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return ProfileModel.fromMap(value.docs.first.data());
      } else {
        return null;
      }
    });
  } else {
    return null;
  }
});

class ProfileProvider {
  static Future<bool> addNewProfile(ProfileModel profile) async {
    final collection =
        FirebaseFirestore.instance.collection(FirebaseConstants.userProfile);

    try {
      EasyLoading.show(status: 'Saving Profile...');
      await collection.doc(profile.id).set(profile.toMap());
      EasyLoading.dismiss();
      return true;
    } on Exception catch (e) {
      print(e);
      EasyLoading.showError('Something Went wrong...');
      return false;
    }
  }

  static Future<bool> updateProfile(ProfileModel profile) async {
    final collection =
        FirebaseFirestore.instance.collection(FirebaseConstants.userProfile);

    try {
      EasyLoading.show(status: 'Updating Profile...');
      await collection.doc(profile.id).update(profile.toMap());
      EasyLoading.dismiss();
      return true;
    } on Exception catch (e) {
      print(e);
      EasyLoading.showError('Something Went wrong...');
      return false;
    }
  }
}
