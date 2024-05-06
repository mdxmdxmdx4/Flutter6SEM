import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileOperations {
  static Future<Directory?> getDirectory(String directory) async {
    switch (directory) {
      case 'TemporaryDirectory':
        return await getTemporaryDirectory();
      case 'ApplicationDocumentsDirectory':
        return await getApplicationDocumentsDirectory();
      case 'ApplicationSupportDirectory':
        return await getApplicationSupportDirectory();
      case 'LibraryDirectory':
        return await getLibraryDirectory();
      case 'ExternalStorageDirectory':
        return await getExternalStorageDirectory();
      case 'ExternalCacheDirectories':
        var directories = await getExternalCacheDirectories();
        if (directories != null && directories.isNotEmpty) {
          return directories.first;
        }
        return null;
      default:
        return null;
    }
  }

  static Future<void> writeToFile(Directory directory, String data) async {
    final File file = File('${directory.path}/my_file.txt');
    await file.writeAsString(data);
  }

  static Future<String> readFromFile(Directory directory) async {
    final File file = File('${directory.path}/my_file.txt');
    return await file.readAsString();
  }
}