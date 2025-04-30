import 'package:flutter/material.dart';
import 'package:proyect/utils/calculator_data.dart';
import 'package:proyect/controllers/calculator_controller.dart';
import 'package:proyect/ui/calculator_button.dart';

class Homeprincipal extends StatefulWidget {
  const Homeprincipal({super.key});

  @override
  State<Homeprincipal> createState() => _HomePrincipalState();
}

class _HomePrincipalState extends State<Homeprincipal> {
  final CalculatorController controller = CalculatorController();
  bool showHistory = false;
  void onButtonTap(String symbol) {
    setState(() {
      if (symbol == "AC") {
        controller.clear();
      } else if (symbol == "=") {
        controller.calculate();
      } else if (symbol == "⌫") {
        controller.delete();
      } else if (symbol == "HIST") {
        showHistory = !showHistory;
      } else {
        controller.addInput(symbol);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 12, 12),
      body: SafeArea(
        child: Column(
          children: [
            // Pantalla
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                alignment: Alignment.bottomRight,
                child: Text(
                  showHistory ? "Historial" : controller.input,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // Historial
            if (showHistory)
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            showHistory = false;
                          });
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        label: const Text(
                          'Volver',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView(
                        reverse: true,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children:
                            controller.history
                                .map(
                                  (entry) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: Text(
                                      entry,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            // Botones
            if (!showHistory)
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    itemCount: buttonSymbols.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemBuilder: (context, index) {
                      final symbol = buttonSymbols[index];
                      final color = buttonColors[index];

                      return CalculatorButton(
                        label:
                            symbol == "⌫"
                                ? const Icon(
                                  Icons.backspace_outlined,
                                  color: Colors.white,
                                )
                                : symbol,
                        color: color,
                        onTap: () => onButtonTap(symbol.toString()),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
