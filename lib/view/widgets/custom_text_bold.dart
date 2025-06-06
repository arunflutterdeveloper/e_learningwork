import 'package:flutter/material.dart';

import '../../utill/dimensions.dart';

class CustomTextBold extends StatelessWidget {
  String text;
  int? maxLines;
  TextAlign? textAlign;
  double? fontSize;
  Color? color;

  CustomTextBold(this.text, {this.maxLines, this.textAlign,this.fontSize,this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'EuclidMedium',
        fontWeight: FontWeight.bold,
        fontSize: fontSize ?? Dimensions.fontSizeDefault,
        color: color ?? Colors.black,
      ),
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}
