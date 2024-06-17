import 'package:file_transfer/src/home/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FileTransferApp());
}

class FileTransferApp extends StatelessWidget {
  const FileTransferApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transfer files',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Transfer Files'),
    );
  }
}
