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
  late String selected;
  final List<String> options = ["Somar", "Subtrair", "Multiplicar", "Dividir"];

  void _calculaResultado(){
    setState(() {
      if(selected == "Somar"){
        _resultado = valorX + valorY;
      }else if(selected == "Subtrair"){
        _resultado = valorX - valorY;
      }else if(selected == "Multiplicar"){
        _resultado = valorX * valorY;
      }else if(selected == "Dividir" && valorY != 0 && valorX != 0){
        _resultado = (valorX / valorY) as int;
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Não é possível dividir por zero"),
            duration: Duration(seconds: 1),
          )
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    valorX = 0;
    valorY = 0;
    _resultado = 0;
    selected = options.first;
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                    child: Text("X: $valorX "),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(WidgetState.pressed)) {
                          return Colors.blueGrey.shade500;
                        }
                        return Colors.blueGrey;
                      }),
                      elevation: WidgetStateProperty.resolveWith<double>((states) {
                        if (states.contains(WidgetState.pressed)) {
                          return 2;
                        }
                        return 4;
                      }),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12.0, horizontal: 35.0)),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                    onPressed: () => navegaTelaPreencher(context, "/preencherX"),
                    child: const Text("Informar X"),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0), child: Text("X: $valorY "),),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(WidgetState.pressed)) {
                          return Colors.blueGrey.shade500;
                        }
                        return Colors.blueGrey;
                      }),
                      elevation: WidgetStateProperty.resolveWith<double>((states) {
                        if (states.contains(WidgetState.pressed)) {
                          return 2;
                        }
                        return 4;
                      }),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12.0, horizontal: 35.0)),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                    onPressed: () => navegaTelaPreencher(context, '/preencherY'),
                    child: const Text("Informar Y"),)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
              child: CustomRadio(
                  options: options,
                  selected: selected,
                  onChanged: (value) {
                    setState(() {
                      selected = value;
                    });
                  }
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.blueGrey.shade500;
                    }
                    return Colors.blueGrey;
                  }),
                  elevation: WidgetStateProperty.resolveWith<double>((states) {
                    if (states.contains(WidgetState.pressed)) {
                      return 2;
                    }
                    return 4;
                  }),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12.0, horizontal: 35.0)),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                onPressed: _calculaResultado,
                child: const Text("Calcular")
            ),
            const SizedBox(height: 10,),
            Text("Resultado: $_resultado",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
            )
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
                Padding(padding: EdgeInsets.all(10.0), child: Text("set $xory: ")),
                Expanded(
                  child:
                    Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Digite um valor",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.pressed)) {
                    return Colors.blueGrey.shade500;
                  }
                  return Colors.blueGrey;
                }),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                elevation: WidgetStateProperty.resolveWith<double>((states) {
                  if (states.contains(WidgetState.pressed)) {
                    return 2;
                  }
                  return 4;
                }),
                padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0)),
              ),
              onPressed: () {
                Navigator.pop(context, int.parse(_controller.text));
              },
              child: const Text("OK"),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRadio extends StatefulWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onChanged;

  const CustomRadio({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged
  });

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {

  final Map<String, IconData> operationIcons = {
    "somar": Icons.add,
    "subtrair": Icons.remove,
    "multiplicar": Icons.clear,
    "dividir": Icons.percent,
  };


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.options.map((option) {
        final bool isSelected = widget.selected == option;
        return GestureDetector(
          onTap: () => widget.onChanged(option),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 6),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blueGrey.shade600 : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              operationIcons[option.toLowerCase()],
              color: isSelected ? Colors.white : Colors.black,
              size: 28,
            ),
          ),
        );
      }).toList(),
    );
  }
}
