import 'package:file_transfer/src/common/address.dart';
import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({super.key, required this.address});

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(address.ip),
        Container(width: 30,),
        Text(address.port.toString()),
      ],
    );
  }
}
