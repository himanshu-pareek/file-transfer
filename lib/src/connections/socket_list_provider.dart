import 'dart:io';

import 'package:flutter/material.dart';

class SocketListProvider with ChangeNotifier {
  final List<Socket> _sockets = [];

  List<Socket> get sockets => _sockets;

  void addSocket(Socket socket) {
    print('Adding socket ${socket}');
    if (!_sockets.contains(socket)) {
      _sockets.add(socket);
      notifyListeners();
      socket.forEach((element) {
        final message = String.fromCharCodes(element);
        if (message.toLowerCase().startsWith("exit")) {
          socket.close();
          removeSocket(socket);
        } else {
          socket.write('Reply: ${message}');
        }
      });
    }
  }

  void removeSocket(Socket socket) {
    print('Removing socket ${socket}');
    if (_sockets.contains(socket)) {
      _sockets.remove(socket);
      notifyListeners();
    }
  }
}
