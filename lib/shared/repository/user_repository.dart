import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cqaaq_app/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// [FirebaseStorage] instance
final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

class UserRepo {
  static final UserRepo _instance = UserRepo();
  static UserRepo get instance => _instance;

  /// [FirebaseAuth] instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// [FirebaseCaller] instance
  final FirebaseCaller _firebaseCaller = FirebaseCaller.instance;

  // phone authentification
  Future<void> verifyWithPhoneNumber(
    String phoneNumber,
    Function(PhoneAuthCredential) onCodeSent,
    Function(String) onVerificationFailed,
    Function(PhoneAuthCredential) onVerificationCompleted,
    Function(String) onCodeAutoRetrievalTimeout,
  ) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential userCredential) {
          onVerificationCompleted(userCredential);
        },
        verificationFailed: (FirebaseAuthException e) {
          onVerificationFailed(e.message ?? 'Verification failed');
        },
        codeSent: (String verificationId, int? resendToken) {
          onCodeSent(
            PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: '',
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          onCodeAutoRetrievalTimeout(verificationId);
        },
      );
    } catch (e) {
      logger.e("Error verifying phone number: $e");
      rethrow;
    }
  }

  /// sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      logger.d("User: ${userCredential.user}");
      return userCredential.user;
    } catch (e) {
      logger.e("Error signing in with email and password: $e");
      rethrow;
    }
  }

  /// sign in with phone
  Future<ConfirmationResult?> signInWithPhone(String phone) async {
    try {
      final ConfirmationResult confirmationResult = await _auth.signInWithPhoneNumber(phone);
      return confirmationResult;
    } catch (e) {
      logger.e("Error signing in with phone: $e");
      rethrow;
    }
  }

  /// Signs up the user with the given email and password.
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      logger.e("Error signing up with email and password: $e");
      rethrow;
    }
  }

  Future<bool> checkUserData(String uid) async {
    return await _firebaseCaller.getData(
      path: FirestorePaths.userDocument(uid),
      builder: (data, docId) {
        logger.i('User data: $data docId $docId');
        if (docId != null) {
          return true;
        }
        return false;
      },
    );
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      logger.e("Error signing out: $e");
      rethrow;
    }
  }

  /// reload user
  Future<void> reloadUser() async {
    try {
      final User? user = _auth.currentUser;
      await user?.reload();
    } catch (e) {
      logger.e("Error reloading user: $e");
      rethrow;
    }
  }

  /// delete user
  Future<String?> deleteUser() async {
    try {
      final User? user = _auth.currentUser;
      await user?.delete();
      return null;
    } catch (e) {
      logger.e("Error deleting user: $e");
      // remove everythin in this format [**] and returnt the error message
      String error = e.toString().replaceAll(RegExp(r'\[.*\]'), '');
      return error.toString();
    }
  }

  /// Sends a password reset email to the user with the given email address.
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      logger.e("Error sending password reset email: $e");
      rethrow;
    }
  }

  /// save user data to firebase
  Future<bool> saveUserData(Map<String, dynamic> userData) async {
    try {
      final User? user = _auth.currentUser;
      await _firebaseCaller.setData(
        path: FirestorePaths.userDocument(user!.uid),
        data: userData,
      );
      return true;
    } catch (e) {
      logger.e("Error saving user data: $e");
      return false;
    }
  }

  /// get user data from firebase
  Future<UserModel?> getUserData() async {
    try {
      final User? user = _auth.currentUser;
      final Map<String, dynamic>? userData = await _firebaseCaller.getData(
        path: FirestorePaths.userDocument(user!.uid),
        builder: (Map<String, dynamic>? data, String? documentId) {
          if (data != null) {
            // logger.i("User data: $data");
            return data;
          }
          return null;
        },
      );
      if (userData == null) {
        return null;
      }
      UserModel userDataModel = UserModel.fromJson(userData);
      return userDataModel;
    } catch (e) {
      logger.e("Error getting user data: $e");
      rethrow;
    }
  }

  // get all users
  Future<List<UserModel>> getUsers() async {
    try {
      return await _firebaseCaller.getCollectionData(
        path: FirestorePaths.usersCollection,
        builder: (List<QueryDocumentSnapshot<Map<String, dynamic>>>? data) async {
          if (data != null) {
            List<UserModel> users = <UserModel>[];
            for (QueryDocumentSnapshot<Map<String, dynamic>> document in data) {
              Map<String, dynamic> dataObject = document.data();
              UserModel userModel = UserModel.fromJson(dataObject);
              // logger.i('User >>>> ::: ${userModel.toJson()}');
              users.add(userModel);
            }
            return users;
          }
          return [];
        },
      );
    } catch (e) {
      logger.e("Error getting users: $e");
      rethrow;
    }
  }

  /// update user data
  Future<bool> updateUserData(Map<String, dynamic> userData) async {
    try {
      final User? user = _auth.currentUser;
      await _firebaseCaller.updateData(
        path: FirestorePaths.userDocument(user!.uid),
        data: userData,
      );
      return true;
    } catch (e) {
      logger.e("Error updating user data: $e");
      return false;
    }
  }

  /// delete user data
  Future<void> deleteUserData() async {
    try {
      final User? user = _auth.currentUser;
      await _firebaseCaller.deleteData(
        path: FirestorePaths.userDocument(user!.uid),
      );
    } catch (e) {
      logger.e("Error deleting user data: $e");
      rethrow;
    }
  }

  /// upload image with [File] to [FirebaseStorage] with filepath [image]
  Future<String> uploadImageWithFile(File image, {String folderName = 'images'}) async {
    try {
      final String fileName = image.path.split('/').last;
      final Reference ref = _firebaseStorage.ref().child('$folderName/$fileName');
      final UploadTask uploadTask = ref.putFile(image);
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return '';
    }
  }

  /// delete image from [FirebaseStorage] with filepath [image]
  Future<void> deleteImage(String image, {String folderName = 'images'}) async {
    try {
      final String fileName = image.split('/').last;
      final Reference ref = _firebaseStorage.ref().child('$folderName/$fileName');
      await ref.delete();
    } catch (e) {
      logger.e("Error deleting image: $e");
    }
  }
}
