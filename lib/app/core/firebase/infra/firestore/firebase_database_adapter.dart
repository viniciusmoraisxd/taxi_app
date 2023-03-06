import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core.dart';

class FirebaseDatabaseAdapter implements FirebaseFirestoreClient {
  late final FirebaseFirestore firestore;
  late final FirebaseAuth firebaseAuth;

  FirebaseDatabaseAdapter() {
    firestore = FirebaseFirestore.instance;
    firebaseAuth = FirebaseAuth.instance;
  }

  @override
  Future save(
      {required Map<String, dynamic> json, required String collection}) async {
    try {
      if (firebaseAuth.currentUser != null) {
        json.addAll({"uid": firebaseAuth.currentUser!.uid});
        await firestore
            .collection(collection)
            .add(json)
            .timeout(const Duration(seconds: 5));
      } else {
        throw FirebaseFirestoreError.accessDenied;
      }
    } on FirebaseException {
      throw FirebaseFirestoreError.unexpected;
    }
  }

  @override
  Future<QuerySnapshot> load({required String collection}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot;

    try {
      if (firebaseAuth.currentUser != null) {
        snapshot = await firestore
            .collection(collection)
            .where("uid", isEqualTo: firebaseAuth.currentUser!.uid)
            .get();
      } else {
        throw FirebaseFirestoreError.accessDenied;
      }
    } on FirebaseException {
      throw FirebaseFirestoreError.accessDenied;
    }

    return snapshot;
  }
}
