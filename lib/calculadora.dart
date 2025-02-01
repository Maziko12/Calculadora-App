import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:core';

// Participantes: Leonardo Henrique Cenovicz, João Paulo Silva Brito, Ana Emilia E. G. Z. Brito,
// Leonardo Correia Valentim

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _limpar = 'Limpar';
  String _expressao = '';
  String _resultado = '';

  double calcularSeno(double x) {
    return sin(x);
  }

  double calcularCosseno(double x) {
    return cos(x);
  }

  double calcularTangente(double x) {
    return tan(x);
  }

  double calcularMedia(List<double> numeros) {
    double soma = numeros.reduce((a, b) => a + b);
    return soma / numeros.length;
  }

  num exponenciar(double base, double escala) {
    return pow(base, escala);
  }

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == _limpar) {
        _expressao = '';
        _resultado = '';
      } else if (valor == 'seno') {
        _resultado = calcularSeno(double.parse(_expressao)).toString();
      } else if (valor == 'cos') {
        _resultado = calcularCosseno(double.parse(_expressao)).toString();
      } else if (valor == 'tan') {
        _resultado = calcularTangente(double.parse(_expressao)).toString();
      } else if (valor == 'média') {
        List<double> numeros =
            _expressao.split(',').map((e) => double.parse(e.trim())).toList();
        _resultado = calcularMedia(numeros).toString();
      } else if (valor == 'expo') {
        List<String> partes = _expressao.split(',');
        _resultado =
            exponenciar(
              double.parse(partes[0]),
              double.parse(partes[1]),
            ).toString();
      } else if (valor == '=') {
        _calcularResultado();
      } else {
        _expressao += valor;
      }
    });
  }

  void _calcularResultado() {
    try {
      _resultado = _avaliarExpressao(
        _expressao,
      ).toString().replaceAll('.', ',');
    } catch (e) {
      _resultado = 'Não foi possível calcular';
    }
  }

  double _avaliarExpressao(String expressao) {
    expressao = expressao
        .replaceAll('x', '*')
        .replaceAll('÷', '/')
        .replaceAll(',', '.');
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    return avaliador.eval(Expression.parse(expressao), {});
  }

  Widget _botao(String valor) {
    return TextButton(
      child: Text(
        valor,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      onPressed: () => _pressionarBotao(valor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Text(_expressao, style: const TextStyle(fontSize: 24))),
        Expanded(child: Text(_resultado, style: const TextStyle(fontSize: 24))),
        Expanded(
          flex: 3,
          child: GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 2,
            children: [
              _botao('7'),
              _botao('8'),
              _botao('9'),
              _botao('÷'),
              _botao('4'),
              _botao('5'),
              _botao('6'),
              _botao('x'),
              _botao('1'),
              _botao('2'),
              _botao('3'),
              _botao('-'),
              _botao('0'),
              _botao(','),
              _botao('='),
              _botao('+'),
              _botao('('),
              _botao(')'),
              _botao('seno'),
              _botao('cos'),
              _botao('tan'),
              _botao('média'),
              _botao('expo'),
            ],
          ),
        ),
        Expanded(child: _botao(_limpar)),
      ],
    );
  }
}
