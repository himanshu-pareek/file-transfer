import 'package:file_transfer/src/common/address.dart';
import 'package:file_transfer/src/common/address_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyAddressWidget extends StatelessWidget {
  const MyAddressWidget({super.key, required this.port});

  final int port;

  Future<Address> _getMyAddress() async {
    final response = await http.Client().get(Uri.parse('https://api.ipify.org'));
    final ip = response.body;
    return Address(ip: ip, port: port);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getMyAddress(), builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return ErrorWidget(snapshot.error!);
          }
          if (snapshot.data == null) {
            return ErrorWidget('Something went wrong');
          }
          return AddressWidget(address: snapshot.data!);
        } else {
          return const LinearProgressIndicator(semanticsLabel: 'Loading...',);
        }
      },
      );
  }
}
