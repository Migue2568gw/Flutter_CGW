import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final Color color;
  final dynamic label;
  final VoidCallback onTap;

  const CalculatorButton({
    super.key,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(255),
        ),
        child: Center(
          child:
              label is String
                  ? Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                  : label,
        ),
      ),
    );
  }
}
