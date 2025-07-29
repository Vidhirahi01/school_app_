import 'package:firebase_auth/firebase_auth.dart';

Future<void> signUp(String emailAddress, String password) async {
  try {
    final UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
    print('Sign-up successful! User UID: ${credential.user?.uid}');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      print('The email address is already in use by another account.');
    } else if (e.code == 'invalid-email') {
      print('The email address is not valid.');
    } else if (e.code == 'weak-password') {
      print('The password is too weak.');
    } else {
      print('Error: ${e.message}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

// Add this function for login
Future<User?> signIn(String emailAddress, String password) async {
  try {
    final UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
    print('Login successful! User UID: ${credential.user?.uid}');
    return credential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    } else if (e.code == 'invalid-email') {
      print('The email address is not valid.');
    } else {
      print('Error: ${e.message}');
    }
  } catch (e) {
    print('Error: $e');
  }
  return null;
}

Future<void> sendPasswordResetEmail(String emailAddress) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
    print('Password reset email sent to $emailAddress.');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'invalid-email') {
      print('The email address is not valid.');
    } else {
      print('Error: ${e.message}');
    }
  } catch (e) {
    print('Error: $e');
  }
}