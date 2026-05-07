import 'package:flutter/material.dart';

void main() => runApp(const AppEdad());

class AppEdad extends StatelessWidget {
  const AppEdad({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Edad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4), // morado Material 3
        ),
      ),
      home: const PantallaEdad(),
    );
  }
}

class PantallaEdad extends StatefulWidget {
  const PantallaEdad({super.key});

  @override
  State<PantallaEdad> createState() => _PantallaEdadState();
}

class _PantallaEdadState extends State<PantallaEdad> {
  final _controller = TextEditingController();
  int? _edad;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _calcular() {
    final texto = _controller.text.trim();
    final anio = int.tryParse(texto);
    final anioActual = DateTime.now().year;

    setState(() {
      if (anio == null) {
        _error = 'Ingresa un año válido';
        _edad = null;
      } else if (anio < 1900 || anio > anioActual) {
        _error = 'El año debe estar entre 1900 y $anioActual';
        _edad = null;
      } else {
        _error = null;
        _edad = anioActual - anio;
      }
    });
  }

  String _mensajeEdad(int edad) {
    if (edad <= 12) return '¡Eres muy joven! 🧒';
    if (edad <= 17) return '¡Eres un adolescente! 🎒';
    if (edad <= 25) return '¡En la flor de la juventud! 🌸';
    if (edad <= 59) return '¡Toda una experiencia de vida! 💪';
    return '¡Una vida llena de sabiduría! 🌟';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        title: const Text('🎂 Calculadora de Edad'),
        backgroundColor: colors.primaryContainer,
        foregroundColor: colors.onPrimaryContainer,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),

            // Tarjeta de instrucción
            Card(
              color: colors.secondaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: colors.onSecondaryContainer),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '¡Ingresa tu año de nacimiento y calcula tu edad!',
                        style: TextStyle(color: colors.onSecondaryContainer),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Campo de texto
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                labelText: 'Año de nacimiento',
                hintText: 'Ej: 2000',
                errorText: _error,
                prefixIcon: const Icon(Icons.cake_outlined),
                filled: true,
                fillColor: colors.surfaceContainerHighest,
              ),
            ),

            const SizedBox(height: 16),

            // Botón
            FilledButton.icon(
              onPressed: _calcular,
              icon: const Icon(Icons.calculate_outlined),
              label: const Text(
                'Calcular mi edad',
                style: TextStyle(fontSize: 16),
              ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Resultado
            if (_edad != null)
              Card(
                color: colors.primaryContainer,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
                  child: Column(
                    children: [
                      Icon(Icons.celebration, size: 48, color: colors.primary),
                      const SizedBox(height: 12),
                      Text(
                        '¡Tienes $_edad años!',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: colors.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _mensajeEdad(_edad!),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: colors.onPrimaryContainer,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}