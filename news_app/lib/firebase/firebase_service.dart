import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _userCollection = FirebaseFirestore.instance.collection("users");
  final _suggestionCollection = FirebaseFirestore.instance.collection("suggestions");
  bool flag = false;

  Future<void> createUser({required String name, required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {
        flag = true;
        registerUser(email: email, password: password, name: name);

        // register user
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> logIn({required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        Fluttertoast.showToast(msg: "Success Login");
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> registerUser({required String name, required String email, required String password}) async {
    await _userCollection.doc().set({"email": email, "password": password, "name": name});
  }

  Future<void> registerSuggestion({required String suggestion}) async {
    await _suggestionCollection.doc().set({"suggestion": suggestion});
  }
}
