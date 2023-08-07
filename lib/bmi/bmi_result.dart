import 'package:flutter/material.dart';
import 'package:video_player_app/common/colors.dart';

import '../models/bmi.dart';

class BmiResultWidget extends StatelessWidget {
  const BmiResultWidget({Key? key, required this.bmiResult}) : super(key: key);

  final Bmi bmiResult;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(50, 100, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _YourBmiText(),
              ],
            ),
            _BmiValue(bmiResult: bmiResult),
            _BmiInterpretation(bmiResult: bmiResult),
          ],
        ),
      );
}

class _BmiInterpretation extends StatelessWidget {
  const _BmiInterpretation({Key? key, required this.bmiResult})
      : super(key: key);

  final Bmi bmiResult;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Text(
        bmiResult.getInterpretationText(context),
        key: const ValueKey<String>('BmiInterpretationText'),
        textAlign: TextAlign.center,
        style:
            textTheme.headline5!.copyWith(color: bmiResult.interpretationColor),
      ),
    );
  }
}

class _BmiValue extends StatelessWidget {
  const _BmiValue({Key? key, required this.bmiResult}) : super(key: key);

  final Bmi bmiResult;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          bmiResult.wholeNumber,
          style: textTheme.headline3!.copyWith(color:AppColor.homePageTitle),
        ),
        const SizedBox(height: 5),
        Text(
          bmiResult.decimalPart,
          style: textTheme.headline5!.copyWith(
            color:AppColor.homePageTitle,
            fontSize: 28,
          ),
        ),
      ],
    );
  }
}

class _YourBmiText extends StatelessWidget {
  const _YourBmiText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Text(
      "your bmi",
      style: textTheme.bodyText1!.copyWith(
        color: Colors.black.withOpacity(.55),
        fontSize: 13,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
