import 'package:blood_bank/services/app_theme.dart';
import 'package:flutter/material.dart';

class EditText extends StatelessWidget {

    final String hint;
    final TextEditingController controller ;
   EditText({Key? key,
     required this.hint ,
     required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color:AppTheme.backGroundWidget,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16)
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
