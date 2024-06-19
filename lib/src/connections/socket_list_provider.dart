import 'dart:io';

import 'package:flutter/material.dart';

class SocketListProvider with ChangeNotifier {
  final List<Socket> _sockets = [];

  List<Socket> get sockets => _sockets;

  void addSocket(Socket socket) {
    print('Adding socket ${socket}');
    socket.write('Welcome\n');
    if (!_sockets.contains(socket)) {
      _sockets.add(socket);
      notifyListeners();
    }
  }

  void removeSocket(Socket socket) async {
    print('Removing socket ${socket}');
    await socket.close();
    if (_sockets.contains(socket)) {
      _sockets.remove(socket);
      notifyListeners();
    }
  }
}
