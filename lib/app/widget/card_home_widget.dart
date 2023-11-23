import 'package:flutter/material.dart';

class CardHomeWidget extends StatelessWidget {
  const CardHomeWidget({
    super.key,
    required this.tittle,
    required this.data,
    required this.width,
    required this.colorData,
  });
  final String tittle;
  final String data;
  final double width;
  final Color colorData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorData,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tittle),
          Divider(),
          Align(
            child: Text(data),
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );
  }
}
