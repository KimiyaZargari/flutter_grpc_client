import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final bool isButton;

  const LoadingIndicator({this.isButton = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          height: 16,
            width: 16,
            child: CircularProgressIndicator(
      color: isButton ? Colors.white : null,
    )));
  }
}
