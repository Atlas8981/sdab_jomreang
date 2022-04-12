import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddMusicPage extends StatefulWidget {
  const AddMusicPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddMusicPage> createState() => _AddMusicPageState();
}

class _AddMusicPageState extends State<AddMusicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Music"),
      ),
      body: highLevelWidget(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                openFilePicker();
              },
              child: Text("Add Music File"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openFilePicker() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
      lockParentWindow: true,
    );
    print(result as FilePickerResult);
  }

  Widget highLevelWidget({required List<Widget> children}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            ...children
          ],
        ),
      ),
    );
  }
}
