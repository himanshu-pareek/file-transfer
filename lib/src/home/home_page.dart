import 'dart:io';

import 'package:file_transfer/src/connections/socket_list_provider.dart';
import 'package:file_transfer/src/connections/socket_list_widget.dart';
import 'package:file_transfer/src/home/my_address_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ServerSocket? _socket;
  SocketListProvider? _socketListProvider;

  Future<ServerSocket> _getSocket() async {
    _socket = await ServerSocket.bind(InternetAddress.anyIPv6, 8080);
    return _socket!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _getSocket(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return ErrorWidget(snapshot.error!);
            }
            if (snapshot.data == null) {
              return ErrorWidget('Socket is null');
            }
            return _buildWidget();
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  void dispose() {
    if (_socket != null) {
      _socket!.close();
    }
    super.dispose();
  }

  Widget _buildWidget() {
    _socketListProvider = SocketListProvider();
    _socket!.listen((socket) {
      _socketListProvider!.addSocket(socket);
      socket.write('Welcome User ${_socketListProvider!.sockets.length}');
    });
    return Column(
      children: [
        MyAddressWidget(port: _socket!.port),
        ListenableProvider(
            create: (_) => _socketListProvider!, child: SocketListWidget()),
      ],
    );
  }
}
