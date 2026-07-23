class ReservaModel {
  int? id;
  int clienteId;
  int habitacionId;
  String fechaInicio;
  String fechaFin;

  ReservaModel({
    this.id,
    required this.clienteId,
    required this.habitacionId,
    required this.fechaInicio,
    required this.fechaFin,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "cliente_id": clienteId,
      "habitacion_id": habitacionId,
      "fecha_inicio": fechaInicio,
      "fecha_fin": fechaFin,
    };
  }

  factory ReservaModel.fromMap(Map<String, dynamic> data) {
    return ReservaModel(
      id: data["id"],
      clienteId: data["cliente_id"],
      habitacionId: data["habitacion_id"],
      fechaInicio: data["fecha_inicio"],
      fechaFin: data["fecha_fin"],
    );
  }
}
