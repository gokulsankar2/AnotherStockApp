import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      return credentials.user;
    } 
    on FirebaseAuthException catch (e) {
      throw e.code;
    } 
    catch (e) {
      log("Something went wrong: $e");
      return null;
    }
  }

  Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      return credentials.user;
    }
    on FirebaseAuthException catch (e) {
      throw e.code;
    }
    catch (e) {
      log("Something went wrong: $e");
      return null;
    }
  }

  Future<void> signout() async {
    try{
      await _firebaseAuth.signOut();
    }
    catch(e){
      log("Something went wrong: $e");
    }
  }

  User? get currentUser {
    return FirebaseAuth.instance.currentUser;
  }

  void exceptionHandler(String code) {
    switch(code) {
      case 'email-already-in-use':
        log('Email already in use');
        break;
      case 'invalid-email':
        log('Invalid email');
        break;
      case 'weak-password':
        log('Weak password. Must be at least 8 characters');
        break;
      case 'user-not-found':
        log('User not found');
        break;
      case 'wrong-password':
        log('Wrong password');
        break;
      case 'invalid-credential':
        log('Invalid credential');
        break;
      case 'missing-inputs':
        log('Missing information. Please fill out all fields');
        break;
      default:
        log('Something went wrong');
    }
  }
}
