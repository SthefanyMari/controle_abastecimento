import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AbastecimentoService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String get userId => FirebaseAuth.instance.currentUser!.uid;

  CollectionReference get _collection =>
      firestore.collection('users').doc(userId).collection('abastecimentos');

  Future<void> addAbastecimento(Map<String, dynamic> data) async {
    await _collection.add(data);
  }

  Future<void> deleteAbastecimento(String id) async {
    await _collection.doc(id).delete();
  }

  Stream<List<Map<String, dynamic>>> getAbastecimentos() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }
}
