import 'package:flutter/material.dart';
import 'package:wedding/data/models.dart';

class SearchAddressPopup extends StatelessWidget {
  final List<Address> addresses;
  const SearchAddressPopup({Key? key, required this.addresses}) : super(key: key);

  Widget buildAddress(BuildContext context, Address address) {
    return GestureDetector(
      child: Container(
        child: Text(
          address.address,
          style: const TextStyle(decoration: TextDecoration.underline),
        ),
        padding: const EdgeInsets.all(8),
      ),
      onTap: () {
        Navigator.pop(context, address);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => buildAddress(context, addresses[index]),
      itemCount: addresses.length,
      padding: const EdgeInsets.all(20),
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
