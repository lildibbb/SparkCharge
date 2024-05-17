import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key, required this.title});

  final String title;

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  TextEditingController unitsController = TextEditingController();
  TextEditingController rebateController = TextEditingController();

  double totalCharges = 0.0;
  double totalChargesBeforeRebate = 0.0;
  double rebateAmount = 0.0;
  String? rebateError;

  void calculateTotalCharges() {
    double units = double.tryParse(unitsController.text) ?? 0.0;
    double rebate = double.tryParse(rebateController.text) ?? 0.0;

    if (rebate > 5.0) {
      setState(() {
        rebateError = 'Rebate cannot exceed 5%';
      });
      return;
    }

    double charges = 0.0;

    if (units <= 200) {
      charges = units * 0.218;
    } else if (units <= 300) {
      charges = 200 * 0.218 + (units - 200) * 0.334;
    } else if (units <= 600) {
      charges = 200 * 0.218 + 100 * 0.334 + (units - 300) * 0.516;
    } else {
      charges = 200 * 0.218 + 100 * 0.334 + 300 * 0.516 + (units - 600) * 0.546;
    }

    totalChargesBeforeRebate = charges;
    rebateAmount = charges * rebate / 100;
    totalCharges = charges - rebateAmount;

    setState(() {
      rebateError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Information'),
                                  content: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Units (kWh):'),
                                      Text(
                                          'Enter the consumed electricity units in kilowatt-hour (kWh).'),
                                      SizedBox(height: 8),
                                      Text('Rebate (%):'),
                                      Text(
                                          'Enter the rebate percentage (0-5%).'),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.help),
                          ),
                        ],
                      ),
                      Text(
                        'Electricity Bills Calculator',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Units (kWh)',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.start,
                      ),
                      TextField(
                        controller: unitsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Enter Units (kWh)',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Rebate (%)',
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.start,
                      ),
                      TextField(
                        controller: rebateController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Enter Rebate (%)',
                          errorText: rebateError,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: calculateTotalCharges,
                        child: const Text('Calculate'),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Subtotal Charges:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'RM ${totalChargesBeforeRebate.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Rebate:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'RM ${rebateAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const Divider(thickness: 2.0),
                      const Text(
                        'Grand Total:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'RM ${totalCharges.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const Divider(thickness: 2.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
