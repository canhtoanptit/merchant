import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> login(String email, String password) async {
    AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = authResult.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authResult.user.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<FirebaseUser> getUser() async {
    return await _firebaseAuth.currentUser();
  }
}
