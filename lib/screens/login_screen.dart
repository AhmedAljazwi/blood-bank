import 'package:blood_bank/helpers/helpers.dart';
import 'package:blood_bank/screens/home_screen.dart';
import 'package:blood_bank/screens/register_screen.dart';
import 'package:blood_bank/services/api.dart';
import 'package:flutter/material.dart';

import '../services/app_constant.dart';
import '../services/app_theme.dart';
import '../widgets/boutton_widget.dart';
import '../widgets/text_feaild.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;
  bool _showLogin = true;
  bool _isSecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width:  AppConst.size.width,
        height: AppConst.size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
              end: Alignment.bottomLeft,
             colors: AppTheme.backGroundScreen

          )
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child:
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 30,),
                      Image.asset('assets/images/bloodbank3.png', width: AppConst.size.width/2.5, height:AppConst.size.height/4.5,),
                      const SizedBox(height: 20,),
                            Text('مرحباَ بك!',
                        style: TextStyle(fontWeight:  FontWeight.bold, fontSize: AppConst.size.width/12, color: Colors.white),),
                      const Text('كن من المتبرعين بالدم و إصنع الفرق!',
                          style: TextStyle(fontWeight:  FontWeight.bold, fontSize: 16, color: Colors.white)),
                      const SizedBox(height: 30,),
                      EditText(controller: emailController,hint: 'البريد الإلكتروني', ),
                      const SizedBox(height: 10,),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                        color:AppTheme.backGroundWidget,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16)
                        ),
                        child: TextField(
                          obscureText: _isSecure,
                          decoration: InputDecoration(
                            hintText: 'كلمة المرور',
                            border: InputBorder.none,
                            suffixIcon: IconButton(icon:
                            Icon(Icons.remove_red_eye_outlined,
                            color: _isSecure ? Colors.grey : Colors.red,
                            ),
                             onPressed: () { 
                              setState(() {
                                _isSecure = !_isSecure;
                              });
                             },),
                          ),
                          controller: passwordController
                          ),
                      ),
                      const SizedBox(height: 10,),
                      _isLoading ? Center( child: CircularProgressIndicator(color: Colors.white,),) :
                      Visibility(
                        visible: _showLogin,
                        child: BottonWidget(
                          elevation: 5,
                          color: Colors.white,
                          child:
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Center(
                                child: const Text('تسجيل الدخول', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),)),
                          ),
                          onPressed: ()async{
                            setState(() {
                              _isLoading = true;
                              _showLogin = false;
                            });
                            if(!emailController.text.isEmpty && !passwordController.text.isEmpty) {
                              if(await Api().login(emailController.text, passwordController.text)) {
                              final snackBar = setSnackBar('تم تسجيل الدخول بنجاح', 'تجاهل', () {} );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder:
                                      (_) => HomeScreen()), (route) => false);
                            }
                            else { final snackBar = setSnackBar('خطأ في البريد الإلكتروني أو كلمة المرور', 'تجاهل ', () {});
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      
                            }
                            }
                            else {
                            final snackBar = setSnackBar('الرجاء إدخال جميع الحقول', 'تجاهل', () {});
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                            setState(() {
                              _isLoading = false;
                              _showLogin = true;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('لست بمتبرع؟ ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                          InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder:
                                        (_) => RegisterPage()));
                              },
                              child: const Text('سجل الآن', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(onPressed: (){}, icon: const Icon(Icons.facebook,size:40,color: Colors.white,))
                            ,IconButton(onPressed: (){}, icon: const Icon(Icons.email,size:40,color: Colors.white))
                            ,IconButton(onPressed: (){}, icon:const Icon(Icons.whatsapp,size:40,color: Colors.white))
                          ],
                        ),
                      ),

                    ]),
              ),
            ),
          ),)
      )
    );
  }
}