import 'dart:convert';

class BoletoModel {
  final String? nome;
  final String? dataVencimento;
  final double? valor;
  final String? barcode;

  BoletoModel({
    this.nome,
    this.dataVencimento,
    this.valor,
    this.barcode,
  });

  BoletoModel copyWith({
    String? nome,
    String? dataVencimento,
    double? valor,
    String? barcode,
  }) {
    return BoletoModel(
      nome: nome ?? this.nome,
      dataVencimento: dataVencimento ?? this.dataVencimento,
      valor: valor ?? this.valor,
      barcode: barcode ?? this.barcode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'dataVencimento': dataVencimento,
      'valor': valor,
      'barcode': barcode,
    };
  }

  factory BoletoModel.fromMap(Map<String, dynamic> map) {
    return BoletoModel(
      nome: map['nome'],
      dataVencimento: map['dataVencimento'],
      valor: map['valor'],
      barcode: map['barcode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BoletoModel.fromJson(String source) =>
      BoletoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BoletoModel(nome: $nome, dataVencimento: $dataVencimento, valor: $valor, barcode: $barcode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BoletoModel &&
        other.nome == nome &&
        other.dataVencimento == dataVencimento &&
        other.valor == valor &&
        other.barcode == barcode;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
        dataVencimento.hashCode ^
        valor.hashCode ^
        barcode.hashCode;
  }
}
