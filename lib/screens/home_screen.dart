import 'package:blood_bank/helpers/helpers.dart';
import 'package:blood_bank/screens/login_screen.dart';
import 'package:blood_bank/screens/profile_screen.dart';
import 'package:blood_bank/widgets/donor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../providers/donor_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String valueCity = "الكل";
  String valueBlood = "الكل";
  String hintCity = "المدينة";
  String hintBlood = "فصيلة الدم";
  final itemController = ScrollController();
  bool isMore = false;
  bool isScroll = false;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<DonorProvider>(context, listen: false).getDonorsFromApi();
    }
    );
  }

  checkEnd(ScrollMetrics metrics, DonorProvider provider) {
    isScroll = true;
    isMore = true;
    provider.getDonorsFromApiCustom(valueCity, valueBlood);
    isMore = false;
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.grey[200],
        title: const Text('بنك الدم',style: TextStyle(color: Colors.red,fontSize: 24)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: () async {
              if (await isAuth()) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProfileScreen(),
                  ),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => LoginPage(),
                  ),
                );
              }
            }, icon: const Icon(Icons.person,color: Colors.red,size: 30,)),
          ),
        ],
      ),
      body: Consumer<DonorProvider>(builder: (context, provider, _) {
        return provider.isBusy && !isScroll
        ? Center(
          child: CircularProgressIndicator(),
        )
        : NotificationListener(
          onNotification: (scrollNotification) {
                   if (scrollNotification is ScrollEndNotification && itemController.position.atEdge && itemController.position.pixels != 0) {
                    checkEnd(scrollNotification.metrics, provider);
                  }
                  return false;
                },
          child: Container(
        
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
        
               Directionality(
                textDirection: TextDirection.rtl,
                 child: Card(
                   color: Colors.grey[200],
                   elevation: 12,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.only(
                         bottomLeft: Radius.circular(16),
                        bottomRight:  Radius.circular(16)
                     )
                   ),
                   child: Column(
                     children: [
                       const SizedBox(height: 20,),
                       Padding(
                         padding: EdgeInsets.symmetric(horizontal: 40),
                         child:
                         Column(
                             children: [
                               DropdownButtonFormField(
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
                                     DropdownMenuItem(child: Text('الكل'), value: "الكل",),
                                     DropdownMenuItem(child: Text('بنغازي'), value: "بنغازي",),
                                     DropdownMenuItem(child: Text('طرابلس'), value: "طرابلس",),
                                     DropdownMenuItem(child: Text('المرج'), value: "المرج",),
                                     DropdownMenuItem(child: Text('الخمس'), value: "الخمس",),
                       
                                   ],
                                   onChanged: ( newValue) {
                                     setState(() {
                                       valueCity = newValue!.toString();
                                       hintCity = newValue.toString();
                                     });
                                   }),
                               SizedBox(height: 8,),
                               DropdownButtonFormField(
                                   decoration: InputDecoration(
                                     border: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(20)
                                     ),
                                   ),
                                   hint: Text(hintBlood),
                                   items: [
                                     DropdownMenuItem(child: Text('الكل'), value: "الكل",),
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
                                     setState(() {
                                       valueBlood = newValue!.toString();
                                       hintBlood = newValue.toString();
                                     });
                                   })
                             ]),),
                       const  SizedBox(height: 10,),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 30),
                         child: MaterialButton(
                             height: 50,
                             minWidth: double.infinity,
                             elevation: 0.0,
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(20)
                             ),
                            highlightColor: Color(0xFFC50F03),
                             color: Colors.red,
                             onPressed: () async {
                               isScroll = false;
                               provider.clearListOfDonors();
                               provider.resetPagination();
                               provider.getDonorsFromApiCustom(valueCity, valueBlood);
                       
                             }, child: const Text('بحث',style: TextStyle(color: Colors.white,fontSize: 20),)),
                       ),
                       const SizedBox(height: 20,),
                     ],
                   ),
                 ),
               ),
              Expanded(
                  child:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: provider.listOfDonors.isEmpty ?  Center(child: Text(textAlign: TextAlign.center,'عذرا لا يوجد متبرعين ',style: TextStyle(fontSize: 20,color: Colors.red),)):
                GridView.builder(
                  controller: itemController,
                  itemCount: provider.listOfDonors.length,
                  itemBuilder: (context, index) {
                    if(provider.isMore && provider.listOfDonors.length-1 == index) { return Center(child: CircularProgressIndicator(color: Colors.red),); }
                    
                   return DonorWidget(donor: provider.listOfDonors[index]);
                  }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.93),),
              )
              )
          ]),
            ),
        );
      }),
    );
  }
}