import 'package:flutter/material.dart';

class BmiInfoWidget extends StatelessWidget {
  const BmiInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 155, left: 16, right: 16),
          child: Column(
            children: const [
              _FirstText(),
            ],
          ),
        ),
      );
}

class _FirstText extends StatelessWidget {
  const _FirstText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Text(
      "fill your information to calculate your bmi",
      key: const ValueKey<String>('BmiInfoFirst'),
      textAlign: TextAlign.center,
      style: textTheme.bodyText1!.copyWith(
        color: Colors.black54.withOpacity(.4),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
