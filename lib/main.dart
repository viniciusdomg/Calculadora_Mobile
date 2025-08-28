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

  Future<void> navegaTelaPreencher(BuildContext context, String rota) async{
    var result = await Navigator.pushNamed(context, rota);
    if(!mounted) return;
    setState(() {
      if(rota == '/preencherX'){
        valorX = result as int;
      }else{
        valorY = result as int;
      }
    });
  }

  late int _resultado;
  late int valorX;
  late int valorY;

  void _calculaResultado(){
    setState(() {
      _resultado = valorX + valorY;
    });
  }

  @override
  void initState() {
    super.initState();
    valorX = 0;
    valorY = 0;
    _resultado = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora"),
        ),
        body: Center( child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center( child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("X = $valorX "),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.grey),
                    ),
                    onPressed: () => navegaTelaPreencher(context, "/preencherX"),
                    child: const Text("Informar X"),
                  )
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Y: $valorY "),
                  TextButton(style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.grey)
                  ),
                    onPressed: () => navegaTelaPreencher(context, '/preencherY'),
                    child: const Text("Informar Y"),)
                ],
              ),
            ),

            FloatingActionButton(onPressed: _calculaResultado, child: const Text("Calcular")),
            Text("Resultado: $_resultado")
          ],
        )
        )
    );
  }
}

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                //String valor = _controller.text;
                Navigator.pop(context, int.parse(_controller.value.text));
              },
              child: const Text("OK"),
            ),
          ],
        ),
      ),
    );
  }
}