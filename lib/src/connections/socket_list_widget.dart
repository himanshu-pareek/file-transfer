import 'package:file_transfer/src/connections/socket_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocketListWidget extends StatelessWidget {
  const SocketListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final sockList = context.watch<SocketListProvider>();
    return Text('Number of open sockets: ${sockList.sockets.length}');
  }
}
