import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sistema hotelero"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/habitacion");
              },
              icon: Icon(Icons.hotel),
              label: Text("Habitaciones"),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/cliente");
              },
              icon: Icon(Icons.people),
              label: Text("Clientes"),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/reserva");
              },
              icon: Icon(Icons.calendar_month),
              label: Text("Reservas"),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/pago");
              },
              icon: Icon(Icons.payments),
              label: Text("Pagos"),
            ),
          ],
        ),
      ),
    );
  }
}
