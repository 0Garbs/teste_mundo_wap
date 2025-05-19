import 'package:flutter/material.dart';

mixin Messages<T extends StatefulWidget> on State<T> {
  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(message),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showInfo(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(message),
        ),
        // backgroundColor: Colors.blue,
      ),
    );
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(message),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
