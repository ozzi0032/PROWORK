import 'package:PROWORK/model/model_category.dart';
import 'package:PROWORK/model/model_user.dart';
import 'package:PROWORK/services/helper/firebase.dart';
import 'package:PROWORK/utills/sharedPrefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';

abstract class UserModelDelegate {
  void onLoaded(UserModel user);

  void onLoggedIn(UserModel user);

  void onLogout(UserModel user);
}

class UserViewModel extends ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseService _firebaseFunctions = FirebaseService();
  UserModel user;
  SkillsMapping mappedSkills;
  String _verificationId;
  String message;

  bool isLoading = false;

  Future<void> initOTP(String phoneNumber) async {
    isLoading = true;
    notifyListeners();
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((UserCredential value) {})
          .catchError((error) {
        message = error.toString();
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      message = authException.message;
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> onVerify(String pinCode) async {
    isLoading = true;
    AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: pinCode);
    UserCredential authResult =
        await _firebaseAuth.signInWithCredential(_authCredential);
    User user = authResult.user;
    if (user != null) {
      bool userExists =
          await _firebaseFunctions.checkUserExistance(user.phoneNumber);
      if (!userExists) {
        createUser(user.phoneNumber);
      }
      //Set Login Session
      /*await*/ SharedPrefs.setLoginStatus();
      isLoading = false;
      notifyListeners();
    } else {
      message = 'Error validating OTP, try again';
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createUser(String phoneNumber) async {
    try {
      UserModel newUser = new UserModel();
      newUser.phoneNumber = phoneNumber;
      await _firebaseFunctions.addUser(newUser);
    } catch (err) {}
  }

  Future<void> saveUser(UserModel user) async {
    final storage = LocalStorage('PROWORK');
    try {
      // save the user Info as local storage
      final ready = await storage.ready;
      if (ready) {
        await storage.setItem('userInfo', user.toMap());
      }
    } catch (err) {}
  }

  Future<void> loadUser() async {
    final storage = LocalStorage('PROWORK');
    try {
      final ready = await storage.ready;
      if (ready) {
        final json =
            storage.getItem('userInfo'); //Get user info from the local storage
        if (json != null) {
          user = UserModel.fromFirestore(json);
          notifyListeners();
        }
      }
    } catch (error) {}
  }

  Future<void> clearStorage() async {
    final storage = LocalStorage('PROWORK');
    await storage.clear();
    user = null;
    notifyListeners();
  }

  Future<void> getMappedSkills() async {
    mappedSkills = await _firebaseFunctions.getMappedSkills(user);
  }

  // void updateUser(UserModel newUser) {
  //   if (newUser != null) {
  //     user = newUser;
  //   }
  //   notifyListeners();
  // }

}
