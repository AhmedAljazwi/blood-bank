import 'dart:convert';

import 'package:blood_bank/helpers/helpers.dart';
import 'package:blood_bank/providers/donor_provider.dart';
import 'package:blood_bank/providers/profile_provider.dart';
import 'package:blood_bank/screens/home_screen.dart';
import 'package:blood_bank/services/api.dart';
import 'package:blood_bank/widgets/boutton_widget.dart';
import 'package:blood_bank/widgets/text_feaild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../services/app_constant.dart';
import '../services/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final groupBloodController = TextEditingController();
  final passwordComfirmController = TextEditingController();
  
  bool _isLoading = false;
  bool _showLogin = true;
  String valueCity = "";
  String valueBlood = "";
  String hintCity = "";
  String hintBlood = "";

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).getDonorProfileFromApi();
    }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Consumer<ProfileProvider>(
        builder: (context, provider, _) {
          if(!provider.isBusy) {
          nameController.text = provider.profileOfDonor.name;
          phoneController.text = provider.profileOfDonor.phoneNumber;
          cityController.text = provider.profileOfDonor.city;
          groupBloodController.text = provider.profileOfDonor.bloodType;
          hintBlood = groupBloodController.text;
          valueBlood = groupBloodController.text;
          hintCity = cityController.text;
          valueCity = cityController.text;
          }
           return 
           
        Container(
          height: AppConst.size.height,
          width: AppConst.size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: AppTheme.backGroundScreen
      
              )
          ),
          child: Center(
            child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: provider.isBusy
                    ? Center(
                      child: CircularProgressIndicator(color: Colors.white,),
                    )
                    :
                     Column(
                        children: [
                          Image.asset('assets/images/bloodbank3.png', width: AppConst.size.width/2.5, height:AppConst.size.height/4.5,),
                          Text('بياناتي الشخصية',
                            style: TextStyle(fontWeight:  FontWeight.bold, fontSize: AppConst.size.width/18, color: Colors.white),),
                          const  SizedBox(height: 40,),
                          EditText(controller: nameController,hint: 'الاسم',),
                          const  SizedBox(height: 10,),
                          EditText(controller: phoneController,hint: 'رقم الهاتف',),
                          const SizedBox(height: 10,),
                          Container(
                            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
                            child: DropdownButtonFormField(
                                   decoration: InputDecoration(
                                    fillColor: Colors.white,
                                     border: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(20)
                                     ),
                                   ),
                                   hint: Text(hintBlood),
                                   items: [
                                     DropdownMenuItem(child: Text('A+'), value: "A+",),
                                     DropdownMenuItem(child: Text('A-'), value: "A-",),
                                     DropdownMenuItem(child: Text('B+'), value: "B+",),
                                     DropdownMenuItem(child: Text('B-'), value: "B-",),
                                     DropdownMenuItem(child: Text('O+'), value: "O+",),
                                     DropdownMenuItem(child: Text('O-'), value: "O-",),
                                     DropdownMenuItem(child: Text('AB+'), value: "AB+",),
                                     DropdownMenuItem(child: Text('AB-'), value: "AB-",),
                                  
                                   ],
                                   onChanged: (newValue) {
                                       valueBlood = newValue!.toString();
                                       hintBlood = newValue.toString();
                                   }),
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
                            child: DropdownButtonFormField(
                                   decoration: InputDecoration(
                                     focusColor: Colors.white,
                                     border: OutlineInputBorder(
                                       borderSide: BorderSide(
                                         color: Colors.white
                                       ),
                                         borderRadius: BorderRadius.circular(20)
                                     ),
                                   ),
                                   hint: Text(hintCity),
                                   items: [
                                     DropdownMenuItem(child: Text('بنغازي'), value: "بنغازي",),
                                     DropdownMenuItem(child: Text('طرابلس'), value: "طرابلس",),
                                     DropdownMenuItem(child: Text('المرج'), value: "المرج",),
                                     DropdownMenuItem(child: Text('الخمس'), value: "الخمس",),
                                  
                                   ],
                                   onChanged: ( newValue) {
                                       valueCity = newValue!.toString();
                                       hintCity = newValue.toString();
                                   }),
                          ),
                          const SizedBox(height: 30,),
                          BottonWidget(color: Colors.white, onPressed: () async {
                            showDialog(context: context, builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(child: const Text('تحديث بيانات الحساب'),)
                                ],
                              ),
                              content: const Text('هل أنت متأكد من رغبتك في تحديث بيانات حسابك؟'),
                              actions: [
                                TextButton(onPressed: () async {
                              if(await provider.updateDonorProfileFromApi(nameController.text, phoneController.text, valueBlood, valueCity)) {
                              final snackBar = setSnackBar('تم تحديث بياناتك بنجاح', 'تجاهل', () {} );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder:
                                      (_) => HomeScreen()), (route) => false);
                            }
                            else {
                              Navigator.pop(context);
                            }
                                }, child: const Text('نعم')),
                                TextButton(onPressed: () { Navigator.pop(context); }, child: 
                                Container(
                                  padding: EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 5),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.red),
                                  child: const Text('لا', style: TextStyle(color: Colors.white),),)
                                ),
                              ],
                            ));
                          }, child: const Text('تحديث بياناتي'),minWidth: double.infinity),
                          const SizedBox(height: 10,),
                          BottonWidget(color: Colors.white, onPressed: () async {
                            if(await provider.logOutDonorProfileFromApi()) {
                              
                              final snackBar = setSnackBar('تم تسجيل الخروج', 'تجاهل', () {} );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder:
                                      (_) => HomeScreen()), (route) => false);
                            }
                            else {
                              Navigator.pop(context);
                            }
                          }, child: const Text('تسجيل الخروج'),minWidth: double.infinity),
                          const SizedBox(height: 10,),
                          BottonWidget(color: Colors.white, onPressed: () async {
                            showDialog(context: context, builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(child: const Text('حذف الحساب'),)
                                ],
                              ),
                              content: const Text('هل أنت متأكد من أنك تود حذف حسابك؟'),
                              actions: [
                                TextButton(onPressed: () async {
                                  if(await provider.deleteDonorProfileFromApi()) {
                                  final snackBar = setSnackBar('تم حذف حسابك بنجاح', 'تجاهل', () {} );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder:
                                      (_) => HomeScreen()), (route) => false);
                            }
                                }, child: const Text('نعم')),
                                TextButton(onPressed: () { Navigator.pop(context); }, child: 
                                Container(
                                  padding: EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 5),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.red),
                                  child: const Text('لا', style: TextStyle(color: Colors.white),),)
                                ),
                              ],
                            ));
                          }, child: const Text(' حذف حسابي'),minWidth: double.infinity),
                        ]),
                  ),
                )
            ),
          ),
        );
  }),
    );
  }
}