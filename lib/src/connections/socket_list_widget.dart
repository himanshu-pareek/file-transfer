import 'package:file_transfer/src/connections/socket_list_provider.dart';
import 'package:file_transfer/src/connections/socket_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocketListWidget extends StatelessWidget {
  const SocketListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final socketListProvider = Provider.of<SocketListProvider>(context);
    final socketList = socketListProvider.sockets;
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: socketList.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Text('Number of opened connections - ${socketList.length}');
          }
          return SocketWidget(
            socket: socketList[index - 1],
            onSocketDelete: (socket) async {
              socketListProvider.removeSocket(socket);
            },
          );
        },
      ),
    );
  }
}
