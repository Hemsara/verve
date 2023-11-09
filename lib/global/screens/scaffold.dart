import 'package:flutter/material.dart';

import 'package:verve/res/dimens.dart';

class BodyScaffold extends StatelessWidget {
  final List<Widget> children;
  final PreferredSize? appBar;
  final bool centerAlign;

  const BodyScaffold({
    Key? key,
    required this.children,
    this.appBar,
    this.centerAlign = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.defaultMargin),
          child: Align(
            alignment: centerAlign ? Alignment.center : Alignment.topLeft,
            child: SingleChildScrollView(
              child: Column(
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
