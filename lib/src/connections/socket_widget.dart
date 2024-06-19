import 'dart:io';

import 'package:flutter/material.dart';

class SocketWidget extends StatelessWidget {
  const SocketWidget({
    super.key,
    required this.socket,
    required this.onSocketDelete,
  });

  final Socket socket;
  final void Function(Socket) onSocketDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(socket.remoteAddress.host),
        Text(socket.remotePort.toString()),
        IconButton.outlined(
          onPressed: () {},
          icon: const Icon(Icons.send_outlined),
        ),
        IconButton.outlined(
          onPressed: () async {
            await socket.close();
            this.onSocketDelete(socket);
          },
          icon: const Icon(Icons.delete_outline),
        )
      ],
    );
  }
}
