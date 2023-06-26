import 'package:flutter/material.dart';

class CustomUserCard extends StatelessWidget {
  final String? urlImage;
  final String? userName;

  const CustomUserCard(
      {super.key, required this.urlImage, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child:
                urlImage == null ? const SizedBox() : Image.network(urlImage!)),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(userName ?? 'Unknown'),
              const Divider(
                height: 2,
              )
            ],
          ),
        )
      ],
    );
  }
}
