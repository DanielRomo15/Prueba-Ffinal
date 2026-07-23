class HabitacionModel {
  int? id;
  String numero;
  String tipo;
  double precio;
  String estado;

  HabitacionModel({
    this.id,
    required this.numero,
    required this.tipo,
    required this.precio,
    required this.estado,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "numero": numero,
      "tipo": tipo,
      "precio": precio,
      "estado": estado,
    };
  }

  factory HabitacionModel.fromMap(Map<String, dynamic> data) {
    return HabitacionModel(
      id: data["id"],
      numero: data["numero"],
      tipo: data["tipo"],
      precio: (data["precio"] as num).toDouble(),
      estado: data["estado"],
    );
  }
}
