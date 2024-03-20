import 'dart:convert';

class DadosModel {
  final String nome;
  final double preco;
  final int saldo;
  DadosModel({
    required this.nome,
    required this.preco,
    required this.saldo,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'preco': preco,
      'saldo': saldo,
    };
  }

  factory DadosModel.fromMap(Map<String, dynamic> map) {
    return DadosModel(
      nome: map['nome'] ?? '',
      preco: map['preco']?.toDouble() ?? 0.0,
      saldo: map['saldo']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DadosModel.fromJson(String source) =>
      DadosModel.fromMap(json.decode(source));
}
