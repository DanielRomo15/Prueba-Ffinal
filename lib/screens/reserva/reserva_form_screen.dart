import 'package:flutter/material.dart';

import '../../entities/reserva_model.dart';
import '../../repositories/reserva_repository.dart';

class ReservaFormScreen extends StatefulWidget {
  final ReservaModel? reserva;

  ReservaFormScreen({
    super.key,
    this.reserva,
  });

  @override
  State<ReservaFormScreen> createState() {
    return _ReservaFormScreenState();
  }
}

class _ReservaFormScreenState extends State<ReservaFormScreen> {
  final clienteIdController = TextEditingController();
  final habitacionIdController = TextEditingController();
  final fechaInicioController = TextEditingController();
  final fechaFinController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.reserva != null) {
      clienteIdController.text = widget.reserva!.clienteId.toString();
      habitacionIdController.text = widget.reserva!.habitacionId.toString();
      fechaInicioController.text = widget.reserva!.fechaInicio;
      fechaFinController.text = widget.reserva!.fechaFin;
    }
  }

  Future<void> guardar() async {
    int? clienteId = int.tryParse(clienteIdController.text);
    int? habitacionId = int.tryParse(habitacionIdController.text);

    if (clienteId == null ||
        habitacionId == null ||
        fechaInicioController.text.isEmpty ||
        fechaFinController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ingrese datos válidos")),
      );
      return;
    }

    ReservaModel reserva = ReservaModel(
      clienteId: clienteId,
      habitacionId: habitacionId,
      fechaInicio: fechaInicioController.text,
      fechaFin: fechaFinController.text,
    );

    final reservaRepository = ReservaRepository();

    try {
      if (widget.reserva == null) {
        await reservaRepository.insert(reserva);
      } else {
        reserva.id = widget.reserva!.id;
        await reservaRepository.update(reserva);
      }

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "El cliente o la habitación no existen",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.reserva != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? "Editar reserva" : "Nueva reserva"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: clienteIdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "ID del cliente"),
            ),
            TextField(
              controller: habitacionIdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "ID de la habitación"),
            ),
            TextField(
              controller: fechaInicioController,
              decoration: InputDecoration(
                labelText: "Fecha de inicio",
                hintText: "2026-07-22",
              ),
            ),
            TextField(
              controller: fechaFinController,
              decoration: InputDecoration(
                labelText: "Fecha de fin",
                hintText: "2026-07-25",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: guardar,
              child: Text(esEdicion ? "Actualizar" : "Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
