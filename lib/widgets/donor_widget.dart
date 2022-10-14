import 'dart:ui';

import 'package:blood_bank/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:blood_bank/models/donor.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class DonorWidget extends StatelessWidget {
  const DonorWidget({super.key, required this.donor,});
  final Donor donor;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      splashColor:  Colors.red,
      onTap: () async {
        await FlutterPhoneDirectCaller.callNumber(donor.phoneNumber);
      },

        child: Card(
          elevation: 19,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                   TextWidget(data: donor.bloodType,fontSize:22,textAlign: TextAlign.center,color: Colors.red),
                   TextWidget(data: donor.name,fontSize: 14),
                   TextWidget(data: donor.phoneNumber,fontSize: 12),
                   TextWidget(data: donor.city,fontSize: 12,)

            ])
        ),


    );
  }
}