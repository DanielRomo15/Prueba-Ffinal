class ClienteModel {
  int? id;
  String nombre;
  String telefono;
  String correo;
  String documento;

  ClienteModel({
    this.id,
    required this.nombre,
    required this.telefono,
    required this.correo,
    required this.documento,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nombre": nombre,
      "telefono": telefono,
      "correo": correo,
      "documento": documento,
    };
  }

  factory ClienteModel.fromMap(Map<String, dynamic> data) {
    return ClienteModel(
      id: data["id"],
      nombre: data["nombre"],
      telefono: data["telefono"],
      correo: data["correo"],
      documento: data["documento"],
    );
  }
}
