import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => Calculadora(),
        '/preencherX': (BuildContext context) => PreencherValores(xory: "X"),
        '/preencherY': (BuildContext context) => PreencherValores(xory: "Y"),
      },
    );
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  int _resultado = 0;

  void _calculaResultado(){
    setState(() {
      _resultado++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora"),
        ),
        body: Center( child:
        Column(
          children: [
            Center( child:
              Row(
                children: [
                  Text("X"),
                  TextButton(style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.grey)
                  ),onPressed: () => Navigator.pushNamed(context, '/preencherX'), child: const Text("Informar X"),)
                ],
              ),
            ),
            Center(
              child: Row(
                children: [
                  Text("Y"),
                  TextButton(style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.grey)
                  ),onPressed: () => Navigator.pushNamed(context, '/preencherY'), child: const Text("Informar Y"),)
                ],
              ),
            ),

            FloatingActionButton(onPressed: _calculaResultado, child: const Text("Calcular")),
            Text("$_resultado")
          ],
        )
        )
    );
  }
}

// class Informax extends StatelessWidget {
//   Informax({super.key});
//
//   final TextEditingController _controllerX = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Preencher Valores"),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 const Text("set X: "),
//                 Expanded(
//                   child: TextField(
//                     controller: _controllerX,
//                     decoration: const InputDecoration(
//                       hintText: "Digite um valor",
//                       border: OutlineInputBorder(),
//                     ),
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             FloatingActionButton(
//               onPressed: () {
//                 String valor = _controllerX.text;
//                 print("Valor digitado: $valor");
//               },
//               child: const Icon(Icons.calculate),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class PreencherValores extends StatelessWidget {
  PreencherValores({super.key, required this.xory});

  final String xory;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preencher Valores"),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Text("set $xory: "),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Digite um valor",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: () {
                String valor = _controller.text;
                print("Valor digitado: $valor");
                Navigator.pushNamed(context, '/');
              },
              child: const Text("OK"),
            ),
          ],
        ),
      ),
    );
  }
}