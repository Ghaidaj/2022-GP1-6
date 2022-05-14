import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/controllers/medicalHistoryController.dart';
import 'package:untitled_design/styles/styles.dart';
import 'package:untitled_design/widgets/drop_down.dart';
import 'package:untitled_design/widgets/widgets.dart';

class MedicalHistory extends StatelessWidget {
  MedicalHistory({Key? key}) : super(key: key);
  final _controller = Get.put(MedicalHistoryController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: CustomColors.pageContentColor1,
                ),
              ),
              const Text(
                'Medical History',
                style: TextStyle(
                  fontFamily: CustomFonts.sitkaFonts,
                  color: CustomColors.pageNameAndBorderColor,
                  fontSize: Sizes.sPageName,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.1),
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(Sizes.s8),
          child: ReactiveForm(
            formGroup: _controller.medicalHistoryForm,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.s40,
                horizontal: Sizes.s8,
              ),
              children: [
                buildRadioCard(
                  'Do you have Hypertension?',
                  'hypertension',
                  'Yes',
                  'No',
                ),
                const SizedBox(height: Sizes.s16),
                buildRadioCard(
                  'Do you have heart disease?',
                  'heartDisease',
                  'Yes',
                  'No',
                ),
                const SizedBox(height: Sizes.s16),
                buildDropdownCard(
                  'Blood Group',
                  'bloodGroup',
                  const ['A+', 'A-', 'B+', 'B-', 'O+', 'O-'],
                ),
                const SizedBox(height: Sizes.s16),
                buildRadioCard(
                  'Are you diabetic?',
                  'diabetic',
                  'Yes',
                  'No',
                ),
                const SizedBox(height: Sizes.s24),
                buildSmallText('Do you have any other illnesses?'),
                const SizedBox(height: Sizes.s8),
                CustomTextField(
                  formControl: _controller.medicalHistoryForm
                      .control('otherIllnesses') as FormControl,
                  hint: 'List Illnesses you suffer from',
                ),
                const SizedBox(height: Sizes.s24),
                buildSmallText('What are you allergic to?'),
                const SizedBox(height: Sizes.s8),
                CustomTextField(
                  formControl: _controller.medicalHistoryForm
                      .control('allergicTo') as FormControl,
                  hint: 'List allergic you suffer from',
                ),
                const SizedBox(height: Sizes.s24),
                buildSmallText('Medication details'),
                const SizedBox(height: Sizes.s8),
                CustomTextField(
                  formControl: _controller.medicalHistoryForm
                      .control('medicationDetails') as FormControl,
                  hint: 'List your medication',
                ),
                const SizedBox(height: Sizes.s24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomElevatedButton(
                      title: 'Cancel',
                      onPressed: () => Navigator.pop(context),
                    ),
                    CustomElevatedButton(
                      title: 'Save',
                      onPressed: () {
                        _controller.saveMedicalHistory();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card buildDropdownCard(String title, String fcn, List<String> items) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(Sizes.s8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildSmallText(title),
            const Spacer(),
            SizedBox(
              height: Sizes.s32,
              width: Sizes.s80,
              child: CustomDropDown(
                fontSize: Sizes.s16 - 2.4,
                label: 'Group',
                formControl:
                    _controller.medicalHistoryForm.control(fcn) as FormControl,
                items: items,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildRadioCard(
    String title,
    String fcn,
    String valueText1,
    String valueText2,
  ) {
    return SizedBox(
      height: Sizes.s56,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.s8),
          child: Row(
            children: [
              buildSmallText(title),
              const Spacer(),
              Expanded(child: buildReactiveRadio(fcn, true)),
              buildSmallText(valueText1),
              Expanded(child: buildReactiveRadio(fcn, false)),
              buildSmallText(valueText2),
            ],
          ),
        ),
      ),
    );
  }

  ReactiveRadio<bool> buildReactiveRadio(String fcn, bool value) {
    return ReactiveRadio(
      activeColor: CustomColors.pageContentColor1,
      focusColor: CustomColors.pageContentColor1,
      formControl:
          _controller.medicalHistoryForm.control(fcn) as FormControl<bool>,
      value: value,
    );
  }

  Text buildSmallText(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: CustomColors.pageContentColor1,
        fontFamily: CustomFonts.sitkaFonts,
        fontWeight: FontWeight.w600,
        fontSize: Sizes.s16,
      ),
    );
  }
}
