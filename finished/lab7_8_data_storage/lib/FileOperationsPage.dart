import 'dart:io';

import 'package:flutter/material.dart';
import 'file_operations.dart';

class FileOperationsPage extends StatefulWidget {
  @override
  _FileOperationsPageState createState() => _FileOperationsPageState();
}

class _FileOperationsPageState extends State<FileOperationsPage> {
  final TextEditingController _controller = TextEditingController();
  String _data = '';
  String _selectedDirectory = 'TemporaryDirectory';
  final List<String> _directories = [
    'TemporaryDirectory',
    'ApplicationDocumentsDirectory',
    'ApplicationSupportDirectory',
    'LibraryDirectory',
    'ExternalStorageDirectory',
    'ExternalCacheDirectories',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Operations Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Введите данные'),
              ),
            ),
            DropdownButton<String>(
              value: _selectedDirectory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDirectory = newValue!;
                });
              },
              items: _directories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () async {
                Directory? dir = await FileOperations.getDirectory(_selectedDirectory);
                if (dir != null) {
                  try {
                    await FileOperations.writeToFile(dir, _controller.text);
                    String data = await FileOperations.readFromFile(dir);
                    setState(() {
                      _data = data;
                    });
                  } catch (e) {
                    setState(() {
                      _data = 'Произошла ошибка: $e';
                    });
                  }
                }
              },
              child: Text('Записать и прочитать данные'),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Данные: $_data'),
            ),
          ],
        ),
      ),
    );
  }
}