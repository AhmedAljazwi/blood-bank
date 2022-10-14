import 'package:blood_bank/screens/home_screen.dart';
import 'package:blood_bank/screens/login_screen.dart';
import 'package:blood_bank/services/api.dart';
import 'package:blood_bank/services/app_constant.dart';
import 'package:blood_bank/services/app_theme.dart';
import 'package:blood_bank/widgets/boutton_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/text_feaild.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordComfirmController = TextEditingController();

  bool _isLoading = false;
  bool _showLogin = true;
  String valueCity = "";
  String valueBlood = "";
  String hintCity = "المدينة";
  String hintBlood = "فصيلة الدم";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        body: Container(
          height: AppConst.size.height,
          width: AppConst.size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: AppTheme.backGroundScreen)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'متبرع جديد',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    EditText(controller: nameController, hint: 'الاسم'),
                    const SizedBox(
                      height: 10,
                    ),
                    EditText(controller: emailController, hint: 'البريد الإلكتروني'),
                    const SizedBox(
                      height: 10,
                    ),
                    //blood
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(18)),
                      child: DropdownButtonFormField(
                          dropdownColor: Colors.grey[200],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          hint: Text(hintCity),
                          items: [
                            DropdownMenuItem(
                              child: Text('بنغازي'),
                              value: "بنغازي",
                            ),
                            DropdownMenuItem(
                              child: Text('طرابلس'),
                              value: "طرابلس",
                            ),
                            DropdownMenuItem(
                              child: Text('المرج'),
                              value: "المرج",
                            ),
                            DropdownMenuItem(
                              child: Text('الخمس'),
                              value: "الخمس",
                            ),
                          ],
                          onChanged: (newValue) {
                            setState(() {
                              valueCity = newValue!.toString();
                              hintCity = newValue.toString();
                            });
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //city
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(18)),
                      child: DropdownButtonFormField(
                          dropdownColor: Colors.grey[200],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          hint: Text(hintBlood),
                          items: [
                            DropdownMenuItem(
                              child: Text('A+'),
                              value: "A+",
                            ),
                            DropdownMenuItem(
                              child: Text('A-'),
                              value: "A-",
                            ),
                            DropdownMenuItem(
                              child: Text('B+'),
                              value: "B+",
                            ),
                            DropdownMenuItem(
                              child: Text('B-'),
                              value: "B-",
                            ),
                            DropdownMenuItem(
                              child: Text('O+'),
                              value: "O+",
                            ),
                            DropdownMenuItem(
                              child: Text('O-'),
                              value: "O-",
                            ),
                            DropdownMenuItem(
                              child: Text('AB+'),
                              value: "AB+",
                            ),
                            DropdownMenuItem(
                              child: Text('AB-'),
                              value: "AB-",
                            ),
                          ],
                          onChanged: (newValue) {
                            setState(() {
                              valueBlood = newValue!.toString();
                              hintBlood = newValue.toString();
                            });
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    EditText(controller: phoneController, hint: 'رقم الهاتف'),
                    const SizedBox(
                      height: 10,
                    ),
                    EditText(controller: passwordController, hint: 'كلمة المرور'),
                    const SizedBox(
                      height: 10,
                    ),
                    EditText(controller: passwordComfirmController, hint: 'تأكيد كلمة المرور'),
                    const SizedBox(
                      height: 20,
                    ),
                    _isLoading ? Center(child: CircularProgressIndicator(color: Colors.white),) :
                    Visibility(
                      visible: _showLogin,
                      child: BottonWidget(
                          color: Colors.white,
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                              _showLogin = false;
                            });
                            if (await Api().register(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                                passwordComfirmController.text,
                                valueBlood,
                                phoneController.text,
                                valueCity)) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (_) => HomeScreen()),
                                  (route) => false);
                              final snackBar = SnackBar(
                                content: const Text('!تم تسجيل الحساب بنجاح'),
                                action: SnackBarAction(
                                  label: 'تجاهل',
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              final snackBar = SnackBar(
                                content: const Text('حدث خطأ ما!'),
                                action: SnackBarAction(
                                  label: 'تجاهل',
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            setState(() {
                              _isLoading = false;
                              _showLogin = true;
                            });
                          },
                          child:  Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25),
                                child: Center(
                                    child: Text(
                                  'تسجيل',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                              )),
                    ),
                    //Signin Button
                    const SizedBox(
                      height: 15,
                    ),
                    //not a donor
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'أنا متبرع! ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'الدخول لحسابي',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    )
                  ]),
                ),
              ),
            ),
          ),
        ));
  }
}
