import 'package:flutter/material.dart';

class CenterWrapper extends StatelessWidget {
  const CenterWrapper({Key? key, required this.children}) : super(key: null);

  final Widget children;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.center,
        child: children,
      );
}
