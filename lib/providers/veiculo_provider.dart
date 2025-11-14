import 'package:flutter/material.dart';
import '../models/veiculo_model.dart';
import '../services/veiculo_service.dart';

class VeiculoProvider extends ChangeNotifier {
  final VeiculoService _service = VeiculoService();

  List<Veiculo> _veiculos = [];
  List<Veiculo> get veiculos => _veiculos;

  VeiculoProvider() {
    loadVeiculos();
  }

  void loadVeiculos() {
    _service.getVeiculos().listen((data) {
      _veiculos = data.map((v) {
        return Veiculo.fromMap(v['id'], v);
      }).toList();
      notifyListeners();
    });
  }

  Future<void> addVeiculo(Veiculo v) async {
    final id = await _service.addVeiculo(v.toMap());

    v. id = id;             
    _veiculos.add(v);      
    notifyListeners();     
  }

  Future<void> deleteVeiculo(String id) async {
    await _service.deleteVeiculo(id);
    _veiculos.removeWhere((veiculo) => veiculo.id == id);
    notifyListeners();
  }
}
