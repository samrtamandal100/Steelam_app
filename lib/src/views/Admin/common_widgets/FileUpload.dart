import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileInputField extends StatefulWidget {
  final void Function(FilePickerResult? result) onFileChosen;

  const FileInputField({Key? key, required this.onFileChosen})
      : super(key: key);

  @override
  _FileInputFieldState createState() => _FileInputFieldState();
}

class _FileInputFieldState extends State<FileInputField> {
  String _fileName = 'No file chosen';

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
      widget.onFileChosen(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 213, 198, 198)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.grey[300],
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              child: Text('Choose file'),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                _fileName,
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('File Input Example')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'File Input Sizes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(),
              FileInputField(
                onFileChosen: (result) {
                  if (result != null) {
                    print('File chosen: ${result.files.single.name}');
                  }
                },
              ),
              FileInputField(
                onFileChosen: (result) {
                  if (result != null) {
                    print('File chosen: ${result.files.single.name}');
                  }
                },
              ),
              FileInputField(
                onFileChosen: (result) {
                  if (result != null) {
                    print('File chosen: ${result.files.single.name}');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
