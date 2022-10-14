
import 'package:flutter/material.dart';


class BottonWidget extends StatelessWidget {
  final double? height;
  final double? minWidth;
  final double? elevation;
  final Color? splach;
  Widget child;
  Function() onPressed;
  Color color;

   BottonWidget({required this.color,
     Key? key,
     this.splach,
     required this.onPressed,
     this.height,
     this.elevation,
     this.minWidth,
     required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),

      ),
      elevation: elevation==null ? 0: elevation,
      onPressed: onPressed,
      height: height==null? 50 : height,
      minWidth: minWidth == null ?50: minWidth,
      color: color,
      splashColor: Color(0xffa80808),
      child: child,

    );
  }
}
