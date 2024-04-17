import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

abstract class Exceptions {
  static String errorMessage(dynamic e, {String? server}) {
    if (e is TimeoutException) {
      return 'Looks like the server is taking to long to respond.';
    }

    if (e is http.ClientException) {
      return e.message.toString();
    } else {
      return e.toString();
    }
  }

  static String firebaseAuthErrorMessage(FirebaseAuthException e) {
    if (e.code == 'network-request-failed') {
      return "Please try again later";
    }
    if (e.code == 'credential-already-in-use') {
      return "This credential is already associated with a different user account.";
    }
    if (e.code == 'wrong-password') {
      return "The password is invalid or the user does not have a password.";
    }
    if (e.code == 'email-already-in-use') {
      return "The email address is already in use by another account.";
    }
    if (e.code == 'invalid-email') {
      return "The email address is badly formatted.";
    }
    if (e.code == 'user-disabled') {
      return "The user account has been disabled by an administrator.";
    }
    if (e.code == 'user-not-found') {
      return "There is no user record corresponding to this identifier. The user may have been deleted.";
    }
    if (e.code == 'user-cancelled') {
      return "The user did not grant your application the permissions it requested.";
    } else if (e.code == 'invalid-email' || e.code == 'invalid-password') {
      return "Invalid password";
    } else {
      return "There was an error, please try again";
    }
  }
}
