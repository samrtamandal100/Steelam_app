import 'package:flutter/material.dart';

class ChangePinForm extends StatefulWidget {
  @override
  _ChangePinFormState createState() => _ChangePinFormState();
}

class _ChangePinFormState extends State<ChangePinForm> {
  final TextEditingController _currentPinController = TextEditingController();
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width >
        600; // You can adjust this threshold based on your needs
    return Card(
      margin: EdgeInsets.all(isDesktop ? 32 : 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Change Pin', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 20),
            _buildTextField(
                'Current Pin', 'Enter Current pin', _currentPinController),
            _buildTextField('New Pin', 'Enter New Pin', _newPinController),
            _buildTextField(
                'Confirm Pin', 'Enter Confirm Pin', _confirmPinController),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _updatePin,
                child: Text('Update Pin'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(),
          errorText: controller.text.isEmpty ? '$label is required' : null,
        ),
      ),
    );
  }

  void _updatePin() {
    // Validate and update logic here
    setState(
        () {}); // Trigger re-build to show error messages if any field is empty
  }

  @override
  void dispose() {
    _currentPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }
}
