import 'package:flutter/material.dart';

import 'codele.dart';

class CodeleView extends StatelessWidget {
  final Codele codele;

  const CodeleView({super.key, required this.codele});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: codele.existsInTarget
            ? Colors.white60
            : codele.doesNotExistInTarget
            ? Colors.blueGrey.shade700
            : null,
        border: Border.all(color: Colors.amber, width: 1.5),
      ),
      child: Text(
        codele.letter,
        style: TextStyle(
          fontSize: 16,
          color: codele.existsInTarget
              ? Colors.black
              : codele.doesNotExistInTarget
              ? Colors.white54
              : Colors.white,
        ),
      ),
    );
  }
}
