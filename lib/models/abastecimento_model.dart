import 'package:cloud_firestore/cloud_firestore.dart';

class Abastecimento {
  final String id;
  final DateTime data;
  final double quantidadeLitros;
  final double valorPago;
  final double quilometragem;
  final String tipoCombustivel;
  final String veiculoId;
  final double consumo;
  final String observacao;

  Abastecimento({
    required this.id,
    required this.data,
    required this.quantidadeLitros,
    required this.valorPago,
    required this.quilometragem,
    required this.tipoCombustivel,
    required this.veiculoId,
    required this.consumo,
    required this.observacao,
  });

  factory Abastecimento.fromMap(String id, Map<String, dynamic> map) {
    final dynamic dataField = map['data'];

    // Converte de forma segura para DateTime
    DateTime data;
    if (dataField is Timestamp) {
      data = dataField.toDate();
    } else if (dataField is DateTime) {
      data = dataField;
    } else if (dataField is String) {
      data = DateTime.tryParse(dataField) ?? DateTime.now();
    } else {
      data = DateTime.now();
    }

    return Abastecimento(
      id: id,
      data: data,
      quantidadeLitros: (map['quantidadeLitros'] as num).toDouble(),
      valorPago: (map['valorPago'] as num).toDouble(),
      quilometragem: (map['quilometragem'] as num).toDouble(),
      tipoCombustivel: map['tipoCombustivel'] ?? '',
      veiculoId: map['veiculoId'] ?? '',
      consumo: (map['consumo'] as num).toDouble(),
      observacao: map['observacao'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': Timestamp.fromDate(data), // salva como Timestamp no Firestore
      'quantidadeLitros': quantidadeLitros,
      'valorPago': valorPago,
      'quilometragem': quilometragem,
      'tipoCombustivel': tipoCombustivel,
      'veiculoId': veiculoId,
      'consumo': consumo,
      'observacao': observacao,
    };
  }
}
