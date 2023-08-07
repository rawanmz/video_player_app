import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bmi.dart';
import '../models/bmi_view_model.dart';
import '../bmi/bmi_info.dart';
import '../bmi/bmi_result.dart';
import 'wave_painter.dart';

class BottomContent extends ConsumerStatefulWidget {
  const BottomContent({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomContent> createState() => _BottomContentState();
}

class _BottomContentState extends ConsumerState<BottomContent> {
  Bmi? bmiResult;
  bool isBmiCalculated = false;

  @override
  Widget build(BuildContext context) {
    ref.watch(bmiProvider).when(
          initial: () => isBmiCalculated = false,
          calculated: (bmi) {
            bmiResult = bmi;
            isBmiCalculated = true;
          },
        );

    return CustomPaint(
      painter: const WavePainter(),
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 1000),
        firstChild: const BmiInfoWidget(),
        secondChild: isBmiCalculated
            ? BmiResultWidget(bmiResult: bmiResult!)
            : const SizedBox(),
        crossFadeState: !isBmiCalculated
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
      ),
    );
  }
}
