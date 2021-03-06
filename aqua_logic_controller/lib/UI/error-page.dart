import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Object? error;
  const ErrorPage({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(error.toString()),
      ),
    );
  }
}
