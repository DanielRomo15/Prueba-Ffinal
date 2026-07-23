import 'package:flutter/material.dart';

import 'entities/cliente_model.dart';
import 'entities/habitacion_model.dart';
import 'entities/pago_model.dart';
import 'entities/reserva_model.dart';
import 'screens/cliente/cliente_form_screen.dart';
import 'screens/cliente/cliente_lista_screen.dart';
import 'screens/habitacion/habitacion_form_screen.dart';
import 'screens/habitacion/habitacion_lista_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/pago/pago_form_screen.dart';
import 'screens/pago/pago_lista_screen.dart';
import 'screens/reserva/reserva_form_screen.dart';
import 'screens/reserva/reserva_lista_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sistema hotelero",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => MenuScreen(),
        "/habitacion": (context) => HabitacionListaScreen(),
        "/habitacion/form": (context) {
          final habitacion = ModalRoute.of(context)?.settings.arguments
              as HabitacionModel?;
          return HabitacionFormScreen(habitacion: habitacion);
        },
        "/cliente": (context) => ClienteListaScreen(),
        "/cliente/form": (context) {
          final cliente = ModalRoute.of(context)?.settings.arguments
              as ClienteModel?;
          return ClienteFormScreen(cliente: cliente);
        },
        "/reserva": (context) => ReservaListaScreen(),
        "/reserva/form": (context) {
          final reserva = ModalRoute.of(context)?.settings.arguments
              as ReservaModel?;
          return ReservaFormScreen(reserva: reserva);
        },
        "/pago": (context) => PagoListaScreen(),
        "/pago/form": (context) {
          final pago = ModalRoute.of(context)?.settings.arguments as PagoModel?;
          return PagoFormScreen(pago: pago);
        },
      },
    );
  }
}
