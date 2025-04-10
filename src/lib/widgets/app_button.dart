import 'package:flutter/material.dart';

class AppButton {
  Widget buttons(String text, {required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  Widget buildIconButton(String text, IconData icon,
      {required VoidCallback onPressed}) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      tooltip: text,
    );
  }
}
