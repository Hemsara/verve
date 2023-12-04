import 'package:flutter/material.dart';
import 'package:verve/res/text.dart';

class ErrorInfo extends StatelessWidget {
  final String? text;
  const ErrorInfo({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "⚠️",
            style: TextStyle(fontSize: 50),
          ),
          Text(
            text ?? "Something went wrong",
            style: AppTextStyles.bodyRegularMedium,
          )
        ],
      ),
    );
  }
}
