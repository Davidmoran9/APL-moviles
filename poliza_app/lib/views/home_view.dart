import 'package:flutter/material.dart';
import 'crear_poliza_view.dart';
import 'buscar_poliza_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de Pólizas'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.car_rental,
                size: 100,
                color: Colors.teal,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CrearPolizaView()),
                  );
                },
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Crear Póliza'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                  minimumSize: const Size(250, 60),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BuscarPolizaView()),
                  );
                },
                icon: const Icon(Icons.search),
                label: const Text('Buscar Póliza'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                  minimumSize: const Size(250, 60),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
