import 'package:flutter/material.dart';

import '../../entities/pago_model.dart';
import '../../repositories/pago_repository.dart';

class PagoFormScreen extends StatefulWidget {
  final PagoModel? pago;

  const PagoFormScreen({
    super.key,
    this.pago,
  });

  @override
  State<PagoFormScreen> createState() =>
      _PagoFormScreenState();
}

class _PagoFormScreenState
    extends State<PagoFormScreen> {
  final reservaIdController =
      TextEditingController();

  final metodoPagoController =
      TextEditingController();

  final montoController =
      TextEditingController();

  final fechaController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.pago != null) {
      reservaIdController.text =
          widget.pago!.reservaId.toString();

      metodoPagoController.text =
          widget.pago!.metodoPago;

      montoController.text =
          widget.pago!.monto.toString();

      fechaController.text =
          widget.pago!.fecha;
    }
  }

  Future<void> guardar() async {
    PagoModel pago = PagoModel(
      reservaId: int.parse(
        reservaIdController.text,
      ),
      metodoPago:
          metodoPagoController.text,
      monto: double.parse(
        montoController.text,
      ),
      fecha: fechaController.text,
    );

    final pagoRepository =
        PagoRepository();

    if (widget.pago == null) {
      await pagoRepository.insert(pago);
    } else {
      pago.id = widget.pago?.id;

      await pagoRepository.update(pago);
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.pago != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          esEdicion
              ? "Editar pago"
              : "Nuevo pago",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: reservaIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "ID de la reserva",
              ),
            ),
            TextField(
              controller: metodoPagoController,
              decoration: const InputDecoration(
                labelText: "Método de pago",
              ),
            ),
            TextField(
              controller: montoController,
              keyboardType:
                  const TextInputType
                      .numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: "Monto",
              ),
            ),
            TextField(
              controller: fechaController,
              decoration: const InputDecoration(
                labelText: "Fecha",
                hintText: "2026-07-22",
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