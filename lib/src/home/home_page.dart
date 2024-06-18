import 'dart:io';

import 'package:file_transfer/src/home/my_address_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<ServerSocket> _getSocket() {
    return ServerSocket.bind(InternetAddress.anyIPv6, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FutureBuilder(future: _getSocket(), builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return ErrorWidget(snapshot.error!);
              }
              if (snapshot.data == null) {
                return ErrorWidget('Socket is null');
              }
              return MyAddressWidget(port: snapshot.data!.port);
            }
            return const CircularProgressIndicator();
          }),
        ],
      ),
    );
  }
}
