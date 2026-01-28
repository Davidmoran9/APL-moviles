import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/poliza_controller.dart';

class BuscarPolizaView extends StatefulWidget {
  const BuscarPolizaView({Key? key}) : super(key: key);

  @override
  State<BuscarPolizaView> createState() => _BuscarPolizaViewState();
}

class _BuscarPolizaViewState extends State<BuscarPolizaView> {
  final _nombreController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  void _buscarPoliza() async {
    if (_nombreController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingrese un nombre'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final controller = Provider.of<PolizaController>(context, listen: false);
    await controller.buscarPoliza(_nombreController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Póliza'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Consumer<PolizaController>(
          builder: (context, controller, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: InputDecoration(
                    labelText: 'Nombre del propietario',
                    hintText: 'Ingrese el nombre completo',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _buscarPoliza,
                      color: Colors.teal,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.isLoading ? null : _buscarPoliza,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: controller.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Buscar',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 30),
                if (controller.errorMessage != null)
                  Card(
                    color: Colors.red.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.error, color: Colors.red),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              controller.errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (controller.polizaResponse != null)
                  Expanded(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Información de la Póliza',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            const Divider(height: 30),
                            _buildInfoRow('Propietario:', controller.polizaResponse!.propietario),
                            _buildInfoRow('Modelo:', controller.polizaResponse!.modeloAuto),
                            _buildInfoRow('Valor del auto:', '\$${controller.polizaResponse!.valorSeguroAuto.toStringAsFixed(2)}'),
                            _buildInfoRow('Edad:', '${controller.polizaResponse!.edadPropietario} años'),
                            _buildInfoRow('Accidentes:', '${controller.polizaResponse!.accidentes}'),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.teal.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Costo Total:',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\$${controller.polizaResponse!.costoTotal.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
