import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VeiculoService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String get userId => FirebaseAuth.instance.currentUser!.uid;

  CollectionReference get _collection =>
      firestore.collection('users').doc(userId).collection('veiculos');

  
  Future<String> addVeiculo(Map<String, dynamic> data) async {
    final doc = await _collection.add(data);
    return doc.id; 
  }

  Future<void> deleteVeiculo(String id) async {
    await _collection.doc(id).delete();
  }

  Stream<List<Map<String, dynamic>>> getVeiculos() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }
}
