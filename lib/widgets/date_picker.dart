import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/styles/styles.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    Key? key,
    this.formControl,
    this.label,
    this.height = Sizes.s48,
  }) : super(key: key);
  final FormControl<DateTime>? formControl;
  final String? label;
  final double? height;
  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  FormGroup buildForm() => fb.group(<String, Object>{
        'date': FormControl<DateTime>(value: null),
      });

  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ReactiveDatePicker<DateTime>(
        formControl: widget.formControl,
        firstDate: DateTime(1985),
        lastDate: DateTime(2030),
        builder: (context, picker, child) {
          Widget suffix = InkWell(
            onTap: () {
              _focusNode.unfocus();
              _focusNode.canRequestFocus = false;
              picker.control.value = null;
              Future.delayed(
                const Duration(milliseconds: 100),
                () => _focusNode.canRequestFocus = true,
              );
            },
            child: const Icon(Icons.clear),
          );

          if (picker.value == null) {
            suffix = const Icon(Icons.calendar_today);
          }

          return ReactiveTextField(
            style: const TextStyle(fontSize: Sizes.s16 - 2.4),
            onTap: () {
              if (_focusNode.canRequestFocus) {
                _focusNode.unfocus();
                picker.showPicker();
              }
            },
            valueAccessor: DateTimeValueAccessor(
              dateTimeFormat: DateFormat('dd MMM yyyy'),
            ),
            focusNode: _focusNode,
            formControl: widget.formControl,
            readOnly: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: CustomColors.pageNameAndBorderColor, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: CustomColors.pageNameAndBorderColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              labelText: widget.label,
              labelStyle: const TextStyle(
                color: CustomColors.pageContentColor1,
                fontFamily: CustomFonts.sitkaFonts,
              ),
              suffixIcon: suffix,
            ),
          );
        },
      ),
    );
  }
}
