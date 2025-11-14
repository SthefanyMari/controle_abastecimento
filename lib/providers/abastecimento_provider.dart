import 'package:flutter/material.dart';
import '../models/abastecimento_model.dart';
import '../services/abastecimento_service.dart';

class AbastecimentoProvider extends ChangeNotifier {
  final AbastecimentoService _service = AbastecimentoService();

  List<Abastecimento> _lista = [];
  List<Abastecimento> get lista => _lista;

  AbastecimentoProvider() {
    load();
  }

  void load() {
    _service.getAbastecimentos().listen((data) {
      _lista = data.map((d) {
        return Abastecimento.fromMap(d['id'], d);
      }).toList();
      notifyListeners();
    });
  }

  Future<void> add(Abastecimento a) async {
    await _service.addAbastecimento(a.toMap());
  }

  Future<void> delete(String id) async {
    await _service.deleteAbastecimento(id);
  }
}
