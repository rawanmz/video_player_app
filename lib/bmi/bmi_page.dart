import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player_app/common/colors.dart';

import '../common/constants.dart';
import '../models/bmi.dart';
import '../models/bmi_view_model.dart';
import '../models/gender.dart';
import '../widgets/action_button.dart';
import '../widgets/bottom_content.dart';
import '../widgets/gender_toggle_button.dart';
import '../widgets/height_slider.dart';
import '../widgets/weight_slider.dart';

class BMIPage extends StatelessWidget {
  const BMIPage({Key? key})
      : super(key: key);

  //final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(backgroundColor: AppColor.secondPageContainerGradient1stColor,title: Text("BMI Calculator"),),
      ),
      backgroundColor: Color(0xFF6588f4).withOpacity(.1),
      body: deviceHeight < 700
          ? const SingleChildScrollView(child: _Body())
          : const _Body(),
    );
  }
}

class _Body extends ConsumerStatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  ConsumerState<_Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> {
  Gender selectedGender = Gender.male;
  int height = 170;
  int weight = 65;
  bool isBmiCalculated = false;
  Bmi? bmiResult;

  void _onGenderChanged(Gender newGender) =>
      setState(() => selectedGender = newGender);

  void _onHeightChanged(int newHeight) => setState(() => height = newHeight);

  void _onWeightChanged(int newWeight) => setState(() => weight = newWeight);

  @override
  Widget build(BuildContext context) {
    ref.watch(bmiProvider).when(
          initial: () => isBmiCalculated = false,
          calculated: (bmi) {
            bmiResult = bmi;
            isBmiCalculated = true;
          },
        );
    final deviceSize = MediaQuery.of(context).size;

    return Center(
      child: Container(
        decoration: mainContainerDecoration,
        height:deviceSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const _GenderText(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 45,
                              child: GenderToggleButton(
                                valueKey: const ValueKey<String>('Gender.male'),
                                onTap: isBmiCalculated
                                    ? null
                                    : () => _onGenderChanged(Gender.male),
                                gender: Gender.male,
                                selectedGender: selectedGender,
                                text: "male",
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SizedBox(
                              height: 45,
                              child: GenderToggleButton(
                                valueKey:
                                    const ValueKey<String>('Gender.female'),
                                onTap: isBmiCalculated
                                    ? null
                                    : () => _onGenderChanged(Gender.female),
                                gender: Gender.female,
                                selectedGender: selectedGender,
                                text: "female",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const _HeightText(),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 16),
                      child: HeightSlider(onHeightChanged: _onHeightChanged),
                    ),
                    const _WeightText(),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 16),
                      child: WeightSlider(onWeightChanged: _onWeightChanged),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 250,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  const BottomContent(),
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: ActionButton(height: height, weight: weight),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GenderText extends StatelessWidget {
  const _GenderText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        "gender",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
}

class _HeightText extends StatelessWidget {
  const _HeightText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        "height",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
}

class _WeightText extends StatelessWidget {
  const _WeightText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        "weight",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
}
