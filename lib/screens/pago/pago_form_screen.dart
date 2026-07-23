import 'package:flutter/material.dart';

import '../../entities/pago_model.dart';
import '../../repositories/pago_repository.dart';

class PagoFormScreen extends StatefulWidget {
  final PagoModel? pago;

  PagoFormScreen({
    super.key,
    this.pago,
  });

  @override
  State<PagoFormScreen> createState() {
    return _PagoFormScreenState();
  }
}

class _PagoFormScreenState extends State<PagoFormScreen> {
  final reservaIdController = TextEditingController();
  final metodoPagoController = TextEditingController();
  final montoController = TextEditingController();
  final fechaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.pago != null) {
      reservaIdController.text = widget.pago!.reservaId.toString();
      metodoPagoController.text = widget.pago!.metodoPago;
      montoController.text = widget.pago!.monto.toString();
      fechaController.text = widget.pago!.fecha;
    }
  }

  Future<void> guardar() async {
    int? reservaId = int.tryParse(reservaIdController.text);
    double? monto = double.tryParse(montoController.text);

    if (reservaId == null ||
        monto == null ||
        metodoPagoController.text.isEmpty ||
        fechaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ingrese datos válidos")),
      );
      return;
    }

    PagoModel pago = PagoModel(
      reservaId: reservaId,
      metodoPago: metodoPagoController.text,
      monto: monto,
      fecha: fechaController.text,
    );

    final pagoRepository = PagoRepository();

    try {
      if (widget.pago == null) {
        await pagoRepository.insert(pago);
      } else {
        pago.id = widget.pago!.id;
        await pagoRepository.update(pago);
      }

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("La reserva indicada no existe")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.pago != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? "Editar pago" : "Nuevo pago"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: reservaIdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "ID de la reserva"),
            ),
            TextField(
              controller: metodoPagoController,
              decoration: InputDecoration(labelText: "Método de pago"),
            ),
            TextField(
              controller: montoController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: "Monto"),
            ),
            TextField(
              controller: fechaController,
              decoration: InputDecoration(
                labelText: "Fecha",
                hintText: "2026-07-22",
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
