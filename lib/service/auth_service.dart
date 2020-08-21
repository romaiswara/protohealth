part of 'service.dart';

class AuthServices {
  static Logger logger = Logger('Auth Service');
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  // sign in with google
  static Future<SignInSignUpResult> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final AuthResult result = await _auth.signInWithCredential(credential);

    await googleSignIn.signOut();

    logger.fine('login success ${result.user.uid} - ${result.user.email}');

    return SignInSignUpResult(user: User.fromFirebaseUser(user: result.user));
  }

  // sign out
  static void signOut() async {
    await googleSignIn.signOut();
    _auth.signOut();
  }
}

class SignInSignUpResult {
  final User user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}
