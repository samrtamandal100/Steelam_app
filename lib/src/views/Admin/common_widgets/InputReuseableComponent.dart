// lib/widgets/responsive_form_row.dart
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreFormController extends GetxController {
  // Form fields as observable variables
  var storeName = ''.obs;
  var storeShortCode = ''.obs;
  var address = ''.obs;
  var remarks = ''.obs;
  var electricityMeter = ''.obs;
  var notes = ''.obs;

  // Method to submit the form
  void submitForm() {
    if (storeName.isNotEmpty) {
      // Implementation of form submission logic
      // This could be calling an API or saving data locally
      print('Form submitted with Store Name: ${storeName.value}');
      // Additional logic based on submission outcome
      print(
          "this data is :${storeShortCode.value} ${address.value} ${address.value}");
    }
  }

  // Method to reset the form
  void resetForm() {
    storeName.value = '';
    storeShortCode.value = '';
    address.value = '';
    remarks.value = '';
    electricityMeter.value = '';
    notes.value = '';
  }
}

class StoreForm extends StatelessWidget {
  final StoreFormController controller = Get.put(StoreFormController());

  StoreForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ResponsiveFormRow(
              leftLabel: "Store Name",
              leftHintText: "Enter Store Name",
              leftOnChanged: (val) => controller.storeName.value = val,
              rightLabel: "Store Short Code",
              rightHintText: "Enter Store Short Code",
              rightOnChanged: (val) => controller.storeShortCode.value = val,
            ),
            SizedBox(
              height: 10,
            ),
            ReusableTextArea(
              label: "Textarea",
              hintText: "Enter your text here",
              onChanged: (value) {
                print("Text changed: $value");
              },
            ),
            SizedBox(
              height: 10,
            ),
            ResponsiveFormRow(
              leftLabel: "Electricity Meter (Optional)",
              leftHintText: "Enter Electricity Meter",
              leftOnChanged: (val) => controller.electricityMeter.value = val,
              rightLabel: "Notes (Optional)",
              rightHintText: "Enter Notes",
              rightOnChanged: (val) => controller.notes.value = val,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: controller.submitForm,
              child: const Text("Save New Store"),
            ),
            TextButton(
              onPressed: controller.resetForm,
              child: const Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveFormRow extends StatelessWidget {
  final String leftLabel;
  final String leftHintText;
  final void Function(String) leftOnChanged;
  final String? rightLabel;
  final String? rightHintText;
  final void Function(String)? rightOnChanged;

  const ResponsiveFormRow({
    Key? key,
    required this.leftLabel,
    required this.leftHintText,
    required this.leftOnChanged,
    this.rightLabel,
    this.rightHintText,
    this.rightOnChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDesktop =
        MediaQuery.of(context).size.width > 800; // Desktop threshold
    if (isDesktop && rightLabel != null && rightOnChanged != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ReusableTextField(
              label: leftLabel,
              hintText: leftHintText,
              onChanged: leftOnChanged,
            ),
          ),
          SizedBox(width: 20), // spacing between fields
          Expanded(
            child: ReusableTextField(
              label: rightLabel!,
              hintText: rightHintText!,
              onChanged: rightOnChanged!,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          ReusableTextField(
            label: leftLabel,
            hintText: leftHintText,
            onChanged: leftOnChanged,
          ),
          SizedBox(height: 16),
          if (rightLabel != null && rightOnChanged != null)
            ReusableTextField(
              label: rightLabel!,
              hintText: rightHintText!,
              onChanged: rightOnChanged!,
            ),
        ],
      );
    }
  }
}

class ReusableTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final Function(String) onChanged;
  final TextInputType keyboardType;

  const ReusableTextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.keyboardType = TextInputType.text, // Default to text input
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: onChanged,
          keyboardType:
              keyboardType, // Use the keyboardType passed to the widget
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ReusableTextArea extends StatelessWidget {
  final String label;
  final String hintText;
  final Function(String) onChanged;
  final int maxLines;
  final TextEditingController? controller;

  const ReusableTextArea({
    Key? key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.maxLines = 4, // Default to 4 lines, adjustable as needed
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.grey.shade400, // Customizable border color
              ),
            ),
          ),
        ),
      ],
    );
  }
}
