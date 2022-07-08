import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class EZXSBetaFirebaseUser {
  EZXSBetaFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

EZXSBetaFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<EZXSBetaFirebaseUser> eZXSBetaFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<EZXSBetaFirebaseUser>(
            (user) => currentUser = EZXSBetaFirebaseUser(user));
