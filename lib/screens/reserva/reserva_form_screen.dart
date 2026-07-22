import 'package:flutter/material.dart';

import '../../entities/reserva_model.dart';
import '../../repositories/reserva_repository.dart';

class ReservaFormScreen extends StatefulWidget {
  final ReservaModel? reserva;

  const ReservaFormScreen({
    super.key,
    this.reserva,
  });

  @override
  State<ReservaFormScreen> createState() =>
      _ReservaFormScreenState();
}

class _ReservaFormScreenState
    extends State<ReservaFormScreen> {
  final clienteIdController = TextEditingController();
  final habitacionIdController = TextEditingController();
  final fechaInicioController = TextEditingController();
  final fechaFinController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.reserva != null) {
      clienteIdController.text =
          widget.reserva!.clienteId.toString();

      habitacionIdController.text =
          widget.reserva!.habitacionId.toString();

      fechaInicioController.text =
          widget.reserva!.fechaInicio;

      fechaFinController.text =
          widget.reserva!.fechaFin;
    }
  }

  Future<void> guardar() async {
    ReservaModel reserva = ReservaModel(
      clienteId: int.parse(
        clienteIdController.text,
      ),
      habitacionId: int.parse(
        habitacionIdController.text,
      ),
      fechaInicio: fechaInicioController.text,
      fechaFin: fechaFinController.text,
    );

    final reservaRepository =
        ReservaRepository();

    if (widget.reserva == null) {
      await reservaRepository.insert(reserva);
    } else {
      reserva.id = widget.reserva?.id;

      await reservaRepository.update(reserva);
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.reserva != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          esEdicion
              ? "Editar reserva"
              : "Nueva reserva",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: clienteIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "ID del cliente",
              ),
            ),
            TextField(
              controller: habitacionIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "ID de la habitación",
              ),
            ),
            TextField(
              controller: fechaInicioController,
              decoration: const InputDecoration(
                labelText: "Fecha de inicio",
                hintText: "2026-07-22",
              ),
            ),
            TextField(
              controller: fechaFinController,
              decoration: const InputDecoration(
                labelText: "Fecha de fin",
                hintText: "2026-07-25",
              ),
            ),
            ElevatedButton(
              onPressed: guardar,
              child: Text(
                esEdicion
                    ? "Actualizar"
                    : "Guardar",
              ),
            ),
          ],
        ),
      ),
    );
  }
}