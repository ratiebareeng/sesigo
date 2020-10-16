import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sesigo/model/sesigo_user.dart';
import 'package:sesigo/services/firestore_service.dart';

// handles user authentication using firebase
class AuthService {
  // instance of FirebaseAuth class to help us interact with forebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // create app user object from firebase user
  SesigoUser _createAppUser(User firebaseUser) {
    return firebaseUser != null
        ? SesigoUser(
            uid: firebaseUser.uid,
            name: firebaseUser.displayName,
            email: firebaseUser.email,
            img: firebaseUser.photoURL)
        : null;
  }

  // auth state change stream
  Stream<SesigoUser> get firebaseUser {
    return _firebaseAuth.authStateChanges().map(_createAppUser);
    //.map((User firebaseUser) => _createAppUser(firebaseUser));
  }

  // google signin auth
  Future signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await _firebaseAuth.signInWithCredential(credential);
      // create user in firestore if not exist
      await FirestoreService(
              sesigoUser: _createAppUser(_firebaseAuth.currentUser))
          .updateUserDoc();

      // return app user
      return _createAppUser(_firebaseAuth.currentUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // update user profile
  void updateUser(SesigoUser sesigoUser) async {}

  // signout
  Future signOut() async {
    try {
      await _googleSignIn.signOut();
      return await _firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}

final AuthService authService = AuthService();
