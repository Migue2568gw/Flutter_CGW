class CalculatorController {
  String _input = '';
  final List<String> _history = [];

  String get input => _input;
  List<String> get history => _history.reversed.take(30).toList();

  void addInput(String value) {
    if (value == '×') value = '*';
    if (value == '÷') value = '/';
    if (value == '⌫') {
      delete();
      return;
    }
    if (value == '=') {
      calculate();
      return;
    }
    if (value == 'AC') {
      clear();
      return;
    }
    _input += value;
  }

  void delete() {
    if (_input.isNotEmpty) {
      _input = _input.substring(0, _input.length - 1);
    }
  }

  void clear() {
    _input = '';
  }

  void calculate() {
    try {
      final result = _evaluateExpression(_input);
      _history.add("$_input = $result");
      _input = result.toString();
    } catch (e) {
      _input = 'Error';
    }
  }

  num _evaluateExpression(String expression) {
    final tokens = _tokenize(expression);
    final output = _toPostfix(tokens);
    return _calculatePostfix(output);
  }

  List<String> _tokenize(String expr) {
    final tokens = <String>[];
    final buffer = StringBuffer();

    for (var i = 0; i < expr.length; i++) {
      final char = expr[i];

      if (_isOperator(char)) {
        if (buffer.isNotEmpty) {
          tokens.add(buffer.toString());
          buffer.clear();
        }
        tokens.add(char);
      } else {
        buffer.write(char);
      }
    }

    if (buffer.isNotEmpty) {
      tokens.add(buffer.toString());
    }

    return tokens;
  }

  List<String> _toPostfix(List<String> tokens) {
    final output = <String>[];
    final stack = <String>[];

    final precedence = {'+': 1, '-': 1, '*': 2, '/': 2, '^': 3};

    for (var token in tokens) {
      if (!_isOperator(token)) {
        output.add(token);
      } else {
        while (stack.isNotEmpty &&
            precedence[token]! <= precedence[stack.last]!) {
          output.add(stack.removeLast());
        }
        stack.add(token);
      }
    }

    while (stack.isNotEmpty) {
      output.add(stack.removeLast());
    }

    return output;
  }

  num _calculatePostfix(List<String> tokens) {
    final stack = <num>[];

    for (var token in tokens) {
      if (_isOperator(token)) {
        final b = stack.removeLast();
        final a = stack.removeLast();
        switch (token) {
          case '+':
            stack.add(a + b);
            break;
          case '-':
            stack.add(a - b);
            break;
          case '*':
            stack.add(a * b);
            break;
          case '/':
            stack.add(b == 0 ? throw Exception("División por cero") : a / b);
            break;
          case '^':
            stack.add(a.toDouble().pow(b.toDouble()));
            break;
        }
      } else {
        stack.add(num.parse(token));
      }
    }

    return stack.single;
  }

  bool _isOperator(String char) {
    return ['+', '-', '*', '/', '^'].contains(char);
  }
}

extension on double {
  double pow(double exponent) => MathPow.pow(this, exponent);
}

class MathPow {
  static double pow(double base, double exp) =>
      base == 0 && exp == 0
          ? 1
          : base == 0
          ? 0
          : base.toDouble().pow(exp.toDouble());
}
