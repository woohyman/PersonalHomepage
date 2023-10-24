import 'package:flutter/material.dart';

ButtonStyle getButtonStyle(bool select) {
  return ButtonStyle(
    alignment: Alignment.centerLeft,
    shape: const MaterialStatePropertyAll(RoundedRectangleBorder()),
    foregroundColor: MaterialStateProperty.resolveWith((states) {
      return select ? Colors.white : Colors.white60;
    }),
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      return select ? Colors.blue : Colors.transparent;
    }),
  );
}
