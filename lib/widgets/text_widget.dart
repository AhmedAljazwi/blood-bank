
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  String data;
  Color? color ;
  double? fontSize ;
  TextAlign ?textAlign;

  TextWidget({Key? key,required this.data,this.color , this.fontSize,this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(

      textAlign: textAlign == null ?TextAlign.start:textAlign,
      data,
      style: TextStyle(color: color == null ? Colors.black : color
      , fontSize: fontSize == null ? 16 : fontSize),
    );
  }
}
