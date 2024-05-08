import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/themes/themeprovide.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  final BorderRadius borderRadius;

  const NeuBox({
    Key? key,
    required this.child,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: borderRadius, // Utilizarea proprietății borderRadius
        boxShadow: [
          BoxShadow(
            color:isDarkMode?Colors.black:  Colors.grey.shade300,
            blurRadius: 15,
            offset: const Offset(4, 4),
          ),
          BoxShadow(
            color:isDarkMode?Colors.grey.shade800: Colors.white,
            blurRadius: 15,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: child,
    );
  }
}
