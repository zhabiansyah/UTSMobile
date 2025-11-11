import 'package:flutter/material.dart';
import 'dart:math';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  String _display = '0';

  // Menambahkan karakter ke input
  void _append(String v) {
    setState(() {
      if (_display == '0' && v != '.') {
        _display = v;
      } else {
        // mencegah dua titik pada satu angka
        if (v == '.') {
          // cari token terakhir (angka) apakah sudah ada '.'
          final lastToken = _lastNumberToken(_display);
          if (lastToken.contains('.')) return;
        }
        _display += v;
      }
    });
  }

  // Menghapus semua (clear)
  void _clear() {
    setState(() {
      _display = '0';
    });
  }

  // Backspace (hapus satu karakter)
  void _delete() {
    setState(() {
      if (_display.length <= 1) {
        _display = '0';
      } else {
        _display = _display.substring(0, _display.length - 1);
      }
    });
  }

  // Hitung kuadrat dari nilai terakhir (atau seluruh ekspresi jika hanya satu angka)
  void _square() {
    setState(() {
      try {
        final lastToken = _lastNumberToken(_display);
        if (lastToken.isEmpty) return;
        final val = double.parse(lastToken);
        final squared = (val * val);
        _replaceLastNumberToken(_display, squared.toString());
      } catch (_) {}
    });
  }

  // Akar kuadrat dari nilai terakhir
  void _sqrt() {
    setState(() {
      try {
        final lastToken = _lastNumberToken(_display);
        if (lastToken.isEmpty) return;
        final val = double.parse(lastToken);
        final root = val < 0 ? double.nan : sqrt(val);
        _replaceLastNumberToken(_display, root.toString());
      } catch (_) {}
    });
  }

  // Tekan =
  void _calculate() {
    setState(() {
      try {
        final res = _evaluateExpression(_display);
        // Format hasil: jika integer, tampil tanpa .0
        if (res.isFinite) {
          final isInt = res == res.roundToDouble();
          _display = isInt ? res.toInt().toString() : _trimTrailing(res.toString());
        } else {
          _display = 'Error';
        }
      } catch (e) {
        _display = 'Error';
      }
    });
  }

  // Utility: ambil token angka terakhir dari ekspresi
  String _lastNumberToken(String expr) {
    // ambil dari akhir sampai ketemu operator
    int i = expr.length - 1;
    final buffer = StringBuffer();
    while (i >= 0) {
      final ch = expr[i];
      if ('+-*/'.contains(ch)) break;
      buffer.write(ch);
      i--;
    }
    final s = buffer.toString().split('').reversed.join();
    return s;
  }

  // Utility: ganti angka terakhir dengan string baru
  void _replaceLastNumberToken(String expr, String newNumber) {
    int i = expr.length - 1;
    while (i >= 0 && !'+-*/'.contains(expr[i])) {
      i--;
    }
    final prefix = i >= 0 ? expr.substring(0, i + 1) : '';
    // hilangkan trailing .0 yang tidak perlu
    final formatted = _formatNumberString(newNumber);
    _display = prefix + formatted;
  }

  String _trimTrailing(String s) {
    if (s.contains('.') && s.endsWith('0')) {
      s = s.replaceAll(RegExp(r'0+$'), '');
    }
    if (s.endsWith('.')) s = s.substring(0, s.length - 1);
    return s;
  }

  String _formatNumberString(String s) {
    try {
      final d = double.parse(s);
      if (d == d.roundToDouble()) return d.toInt().toString();
      return _trimTrailing(d.toString());
    } catch (_) {
      return s;
    }
  }

  // EVALUATOR: shunting-yard -> RPN -> evaluate
  double _evaluateExpression(String expr) {
    final tokens = _tokenize(expr);
    final rpn = _toRPN(tokens);
    return _evalRPN(rpn);
  }

  // Tokenizer sederhana (menghasilkan angka sebagai token, operator sebagai token)
  List<String> _tokenize(String expr) {
    final List<String> out = [];
    final buffer = StringBuffer();
    for (int i = 0; i < expr.length; i++) {
      final ch = expr[i];
      if ('0123456789.'.contains(ch)) {
        buffer.write(ch);
      } else if ('+-*/'.contains(ch)) {
        if (buffer.isNotEmpty) {
          out.add(buffer.toString());
          buffer.clear();
        }
        out.add(ch);
      } else {
        // ignore spasi atau karakter lain
      }
    }
    if (buffer.isNotEmpty) out.add(buffer.toString());
    return out;
  }

  // Precedence
  int _prec(String op) {
    if (op == '+' || op == '-') return 1;
    if (op == '*' || op == '/') return 2;
    return 0;
  }

  List<String> _toRPN(List<String> tokens) {
    final output = <String>[];
    final ops = <String>[];
    for (final t in tokens) {
      if (t.isEmpty) continue;
      if (_isNumber(t)) {
        output.add(t);
      } else if ('+-*/'.contains(t)) {
        while (ops.isNotEmpty && _prec(ops.last) >= _prec(t)) {
          output.add(ops.removeLast());
        }
        ops.add(t);
      }
    }
    while (ops.isNotEmpty) {
      output.add(ops.removeLast());
    }
    return output;
  }

  double _evalRPN(List<String> rpn) {
    final stack = <double>[];
    for (final t in rpn) {
      if (_isNumber(t)) {
        stack.add(double.parse(t));
      } else if ('+-*/'.contains(t)) {
        if (stack.length < 2) throw Exception('Invalid expression');
        final b = stack.removeLast();
        final a = stack.removeLast();
        double res;
        switch (t) {
          case '+':
            res = a + b;
            break;
          case '-':
            res = a - b;
            break;
          case '*':
            res = a * b;
            break;
          case '/':
            res = a / b;
            break;
          default:
            throw Exception('Unknown op');
        }
        stack.add(res);
      }
    }
    if (stack.isEmpty) return 0.0;
    return stack.last;
  }

  bool _isNumber(String s) {
    return double.tryParse(s) != null;
  }

  Widget _buildButton(String label,
      {Color? color, Color? textColor, VoidCallback? onTap, double fontSize = 22}) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ElevatedButton(
        onPressed: onTap ?? () => _onButtonPressed(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.white,
          foregroundColor: textColor ?? Colors.black87,
          padding: const EdgeInsets.all(18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
        ),
        child: Text(label, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _onButtonPressed(String label) {
    if (label == 'C') {
      _clear();
    } else if (label == 'DEL') {
      _delete();
    } else if (label == '=') {
      _calculate();
    } else if (label == 'x²') {
      _square();
    } else if (label == '√') {
      _sqrt();
    } else if ('+-*/'.contains(label)) {
      // jangan biarkan operator ganda
      if (_display.isEmpty) return;
      final last = _display[_display.length - 1];
      if ('+-*/'.contains(last)) {
        // ganti operator
        setState(() {
          _display = _display.substring(0, _display.length - 1) + label;
        });
        return;
      } else {
        _append(label);
      }
    } else {
      _append(label);
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyleContent = [
      ['C', 'DEL', '√', '/'],
      ['7', '8', '9', '*'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['0', '.', 'x²', '='],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.green.shade50,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    _display,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: Column(
              children: buttonStyleContent.map((row) {
                return Row(
                  children: row.map((label) {
                    // styling khusus untuk beberapa button
                    Color? bg;
                    Color? txt;
                    double fs = 22;
                    if (label == 'C') {
                      bg = Colors.red.shade300;
                      txt = Colors.white;
                    } else if (label == 'DEL') {
                      bg = Colors.orange.shade300;
                      txt = Colors.white;
                    } else if (label == '=' ) {
                      bg = Colors.green;
                      txt = Colors.white;
                      fs = 24;
                    } else if (label == '/' || label == '*' || label == '-' || label == '+') {
                      bg = Colors.grey.shade200;
                      txt = Colors.black87;
                    } else {
                      bg = Colors.white;
                      txt = Colors.black87;
                    }

                    return Expanded(
                      child: _buildButton(label, color: bg, textColor: txt, fontSize: fs),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
