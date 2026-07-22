class Habitacion {
  final int? id;
  final String numero;
  final String tipo;
  final double precio;
  final String estado;

  Habitacion({
    this.id,
    required this.numero,
    required this.tipo,
    required this.precio,
    required this.estado,
  });

  // Convertir objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero': numero,
      'tipo': tipo,
      'precio': precio,
      'estado': estado,
    };
  }

  // Convertir JSON a objeto
  factory Habitacion.fromJson(Map<String, dynamic> json) {
    return Habitacion(
      id: json['id'],
      numero: json['numero'],
      tipo: json['tipo'],
      precio: double.parse(json['precio'].toString()),
      estado: json['estado'],
    );
  }

  // Crear una copia modificando algunos campos
  Habitacion copyWith({
    int? id,
    String? numero,
    String? tipo,
    double? precio,
    String? estado,
  }) {
    return Habitacion(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      tipo: tipo ?? this.tipo,
      precio: precio ?? this.precio,
      estado: estado ?? this.estado,
    );
  }
}