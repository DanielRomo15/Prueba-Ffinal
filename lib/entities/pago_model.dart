class PagoModel {
  int? id;
  int reservaId;
  String metodoPago;
  double monto;
  String fecha;

  PagoModel({
    this.id,
    required this.reservaId,
    required this.metodoPago,
    required this.monto,
    required this.fecha,
  });

  // TRANSFORMAR UN OBJETO EN UN MAP
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "reserva_id": reservaId,
      "metodo_pago": metodoPago,
      "monto": monto,
      "fecha": fecha,
    };
  }

  // TRANSFORMAR DE MAP A OBJETO
  factory PagoModel.fromMap(Map<String, dynamic> data) {
    return PagoModel(
      id: data["id"],
      reservaId: data["reserva_id"],
      metodoPago: data["metodo_pago"],
      monto: (data["monto"] as num).toDouble(),
      fecha: data["fecha"],
    );
  }
}