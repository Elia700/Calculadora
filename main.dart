import 'package:flutter/material.dart';

void main() => runApp(const CalculadoraApp());

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      home: const Calculadora(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String pantalla = '0';
  double num1 = 0;
  double num2 = 0;
  String operacion = '';

  void presionar(String texto) {
    setState(() {
      if (texto == 'AC') {
        pantalla = '0';
        num1 = 0;
        num2 = 0;
        operacion = '';
        return;
      }

      if (texto == '+' || texto == '-' || texto == '×' || texto == '÷') {
        num1 = double.tryParse(pantalla) ?? 0;
        operacion = texto;
        pantalla = '0';
        return;
      }

      if (texto == '=') {
        num2 = double.tryParse(pantalla) ?? 0;
        double res = 0;
        switch (operacion) {
          case '+':
            res = num1 + num2;
            break;
          case '-':
            res = num1 - num2;
            break;
          case '×':
            res = num1 * num2;
            break;
          case '÷':
            res = num2 != 0 ? num1 / num2 : double.nan;
            break;
        }
        pantalla = res.toString().endsWith('.0')
            ? res.toStringAsFixed(0)
            : res.toString();
        return;
      }

      if (pantalla == '0') {
        pantalla = texto;
      } else {
        pantalla += texto;
      }
    });
  }

  Widget buildBoton(String texto,
      {Color color = const Color(0xFF333333),
        Color textoColor = Colors.white,
        double size = 70}) {
    return GestureDetector(
      onTap: () => presionar(texto),
      child: Container(
        width: texto == '0' ? size * 2 + 10 : size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(35),
        ),
        alignment: Alignment.center,
        child: Text(
          texto,
          style: TextStyle(fontSize: 30, color: textoColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Moderna'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 10, bottom: 30),
              child: Text(
                pantalla,
                style: const TextStyle(fontSize: 60, color: Colors.white),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildBoton('AC', color: Colors.grey),
                    buildBoton('+/-', color: Colors.grey),
                    buildBoton('%', color: Colors.grey),
                    buildBoton('÷', color: Colors.orange),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildBoton('7'),
                    buildBoton('8'),
                    buildBoton('9'),
                    buildBoton('×', color: Colors.orange),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildBoton('4'),
                    buildBoton('5'),
                    buildBoton('6'),
                    buildBoton('-', color: Colors.orange),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildBoton('1'),
                    buildBoton('2'),
                    buildBoton('3'),
                    buildBoton('+', color: Colors.orange),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildBoton('0'),
                    buildBoton('.'),
                    buildBoton('=', color: Colors.orange),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
