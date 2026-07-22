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

  // Transformar un objeto a un map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "numero": numero,
      "tipo": tipo,
      "precio": precio,
      "estado": estado,
    };
  }

  // Transformar un map a un objeto
  factory HabitacionModel.fromMap(Map<String, dynamic> data) {
    return HabitacionModel(
      id: data["id"],
      numero: data["numero"],
      tipo: data["tipo"],
      precio: data["precio"],
      estado: data["estado"],
    );
  }
}