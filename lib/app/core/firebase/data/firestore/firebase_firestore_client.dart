import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseFirestoreClient {
  Future save({required Map<String, dynamic> json, required String collection});

  Future<QuerySnapshot> load({required String collection});
}
