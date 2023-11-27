import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardListWidget extends StatelessWidget {
  const CardListWidget({
    super.key,
    required this.icon,
    required this.date,
    required this.amount,
    required this.desc,
    required this.type,
    this.onPressed,
  });
  final IconData icon;
  final String date;
  final String type;
  final String amount;
  final String desc;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    Color colorsText = Colors.black;
    if (type == 'keluar') {
      colorsText = Colors.red;
    }
    return Container(
      width: Get.width * 90 / 100,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: Get.width * 90 / 100 - 75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                onPressed == null
                    ? Container()
                    : Align(
                        child: GestureDetector(
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onTap: onPressed,
                        ),
                        alignment: Alignment.topRight,
                      ),
                Text(
                  type,
                  style: TextStyle(color: colorsText),
                ),
                Text(desc),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(date),
                    Text(amount),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
