import 'package:flutter/material.dart';
class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  double height;
  int? maxLines;
  TextOverflow? overflow;
  SmallText({super.key,
   this.color = const Color(0xFFccc7c5),
  required this.text,
  this.size =11.5,
  this.height =1.2,
  this.maxLines = 1,
  this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontSize: size,
        height: height
      ),
    );
  }
}