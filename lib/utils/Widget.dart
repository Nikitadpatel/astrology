
import 'dart:convert';
import 'dart:io';

import 'package:astrology2/classes/language.dart';
import 'package:astrology2/classes/language_constant.dart';
import 'package:astrology2/main.dart';
import 'package:astrology2/models/UserModel.dart';
import 'package:astrology2/provider/signupprovider.dart';
import 'package:astrology2/utils/const.dart';
import 'package:astrology2/utils/sharepreferance.dart';
import 'package:astrology2/view/Prognosisinfo.dart';
import 'package:astrology2/view/Progonsis.dart';
import 'package:astrology2/view/Splashscreen.dart';
import 'package:astrology2/view/creataccount.dart';
import 'package:astrology2/view/forgetpassword2.dart';
import 'package:astrology2/view/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


//button
Widget buttonWidget(
    {required VoidCallback callback,
      required double width,
      required String text,
      double? radius,
      Color color = Colors.purple}) {
  return Container(
    height: 40,
    width: width,
    child: TextButton(
      style: ButtonStyle(
        // alignment: Alignment.center,
        backgroundColor: MaterialStateProperty.all(color),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 8.0),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ??20.0),
            )),
      ),
      onPressed: () => callback(),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontFamily: "poppins",
            fontWeight: FontWeight.normal
        ),
      ),
    ),
  );
}

//for language selection
class dropdown extends StatefulWidget {
  const dropdown({Key? key}) : super(key: key);
  @override
  State<dropdown> createState() => _dropdownState();
}
// class Language {
//   final String name;
//   // final String languageCode;
//   Language(this.name);
//   static List<Language> languageList() {
//     return <Language>[
//       Language("English"),
//       Language("Romania"),
//     ];
//   }
//   Language? select= Language("English");
// // int get hashCode => languageCode.hashCode;
// // bool operator==(Object other) => other is Language && other.languageCode == languageCode;
// }
class _dropdownState extends State<dropdown> {



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child:
          DropdownButton(
            // value:language,
            // hint: const Text("Select country",style: TextStyle(
            //     fontSize: 12.0,
            //     color: Colors.black
            // ),),
            icon: const Icon(
                Icons.language,
                color: Colors.white,
              ),
            dropdownColor: Colors.white,
            iconSize: 30,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontFamily: "poppins",
                fontWeight: FontWeight.normal
            ),
            onChanged: (Language? _language) async {
              setState(() {
                // language=_language!;
              });
              if (_language != null) {
                Locale _locale = await setLocale(_language.languageCode);
                MyApp.setLocale(context, _locale);
              }
            },
            // items:_dropdownmenuitem,
            items:(Language !=null)? Language.languageList()
                .map<DropdownMenuItem<Language>>(
                  (e) => DropdownMenuItem<Language>(
                value: e,
                child: Text(e.name),
              ),
            )
                .toList(): null,
          )


    // selectedItemBuilder: (BuildContext context) {
    //     return Language.languageList().map((e) {
    //       return Text(e.name.toString(),
    //           style: const TextStyle(
    //               color: Colors.white,
    //               fontWeight: FontWeight.normal
    //           )
    //       );
    //     }).toList();
        )
          ),
        );


  }
}

//background video
class Videobackground extends StatefulWidget {
  const Videobackground({Key? key}) : super(key: key);

  @override
  State<Videobackground> createState() => _VideobackgroundState();
}
class _VideobackgroundState extends State<Videobackground> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/background.mp4');
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return VideoPlayer(_controller);
  }
}
//small video
class video extends StatefulWidget {
  const video({Key? key}) : super(key: key);
  @override
  State<video> createState() => _videoState();
}
class _videoState extends State<video> {
  late VideoPlayerController _controller1;
  @override
  void initState() {
    super.initState();
    _controller1 = VideoPlayerController.asset('assets/astrology.mp4');

    _controller1.addListener(() {
      setState(() {});
    });
    _controller1.setLooping(true);
    _controller1.initialize().then((_) => setState(() {}));
    _controller1.play();
  }
  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return VideoPlayer(_controller1);
  }
}

//bottom navigation
class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({Key? key}) : super(key: key);

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  var selected=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          // color: Colors.yellow,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>creataccount()));
                setState(() {
                  selected=0;
                });
              }, icon: Icon(Icons.person_outline,color: Colors.black,)),
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Splashscreen()));
                setState(() {
                  selected=0;
                });
              }, icon: Icon(Icons.home_outlined,color: Colors.black,)),
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Progonsis()));
                setState(() {
                  selected=1;
                });
              }, icon: Icon(Icons.location_on_outlined,color: Colors.black,))
            ],
          ),
        ),
      ),

    );
  }
}
class Drawerwidget extends StatefulWidget {
  final BuildContext context;
  const Drawerwidget(this.context,{Key? key}) : super(key: key);

  @override
  State<Drawerwidget> createState() => _DrawerwidgetState();
}

class _DrawerwidgetState extends State<Drawerwidget> {
  @override
  Widget build(BuildContext context) {
    return drawerwidget1(context);
  }
}
Widget drawerwidget1(context,){
  TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontFamily: "poppins",
    fontWeight: FontWeight.normal,
    fontSize: 11.sp,
  );
  double widthDrawer = MediaQuery.of(context).size.width *0.75;
  return SizedBox(
    width: widthDrawer,
    child: Drawer(
        child: Container(
          padding: EdgeInsets.all(2.w),
          alignment: Alignment.center,
          decoration:  BoxDecoration(color: Colors.white),
          child: ListView(
            children: [
              (userData?.data?.registerUsername?.isEmpty ?? true)
                  ? Container(
                    height: 200.0,
                width: 200.0,
              ):
              DrawerHeader(child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment:CrossAxisAlignment.start ,
                    children: [
                      Center(child: Text(translation(context).profile,style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),)),
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // alignment: Alignment.bottomCenter,
                        height: 20.w,
                        width: 20.w,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle
                        ),
                        // margin: EdgeInsets.only(right: 2.h),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text("A")
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData?.data?.registerUsername.toString()  ?? "",
                            style: const TextStyle(fontSize: 15.0,
                                color: Colors.black,fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 1.h,),
                          Text(
                            userData?.data?.registerEmail.toString()  ?? "",
                            style: const TextStyle(fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 1.h,),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>creataccount()));
                            },
                            child: Container(
                              height: 35.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.purple,
                              ), child: Center(child: Text("Edit Profile",style: TextStyle(
                                fontSize: 12.sp,color: Colors.white,fontFamily: "poppins",fontWeight: FontWeight.normal),),),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              )),
              Container(
                // color: Colors.purple,
                padding: EdgeInsets.only(left: 10.0,top: 4.0,bottom: 4.0),
                // alignment: Alignment.center,
                height: 30.0,
                child: GestureDetector(
                  child:  Text(
                    userData == null ? translation(context).login2: translation(context).logout,
                    style: textStyle,
                  ),
                  onTap: ()async{
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const login(),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Container(
                // color: Colors.purple,
                padding: EdgeInsets.only(left: 10.0,top: 4.0,bottom: 4.0),
                // alignment: Alignment.center,
                height: 30.0,
                child: GestureDetector(

                child: Text(translation(context).profile,style: textStyle,),
                  onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>creataccount())
                    );
                  },
                ),
              ),
                Divider(),
              Container(
                // color: Colors.purple,
                padding: EdgeInsets.only(left: 10.0,top: 4.0,bottom: 4.0),
                // alignment: Alignment.center,
                height: 30.0,
                child: GestureDetector(

                  child: Text(translation(context).prognosis,style: textStyle,),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>Prognosisinfo())
                    );
                  },
                ),
              ),
              Divider(),
              Container(
                // color: Colors.purple,
                padding: EdgeInsets.only(left: 10.0,top: 4.0,bottom: 4.0),
                // alignment: Alignment.center,
                height: 30.0,
                child: GestureDetector(
                  child: Text(translation(context).changepassword,style: textStyle,),
                  onTap: (){
                    TextEditingController _password=TextEditingController();
                    TextEditingController _confirm=TextEditingController();
                    final _formKey = GlobalKey<FormState>();
                    UserModel? userDataModel;

                    AlertDialog alert = AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      titlePadding: EdgeInsets.all(5.h),
                      contentPadding: EdgeInsets.only(top: 0.0,bottom: 0.0,left: 20.0),
                      title: Text("Change Password",
                          style: const TextStyle(
                              color: Colors.black,
                              decorationColor: Colors.black,
                              fontFamily: 'poppins')),
                      content: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment:MainAxisAlignment.start ,
                          children: [
                            Container(
                              height: 200.0,
                              width: 70.w,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:MainAxisAlignment.start ,
                                  children: [
                                    Text(translation(context).changepassword,style: TextStyle(fontSize: 10.sp),),
                                    SizedBox(height: 1.h,),
                                    Container(

                                      width:MediaQuery.of(context).size.width,
                                      child: TextFormField(
                                        controller:_password,
                                        style: textStyle,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return translation(context).enternewpassword;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: translation(context).newpassword,
                                          hintStyle:TextStyle(fontSize: 8.sp),
                                          contentPadding: EdgeInsets.only(left: 10.0,top: 5.0,bottom: 5.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                                            borderSide:const BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),),
                                    ),
                                    SizedBox(height: 1.h,),
                                    Text(translation(context).conformpassword,style: TextStyle(fontSize: 10.sp),),
                                    SizedBox(height: 1.h,),
                                    Container(

                                      width:MediaQuery.of(context).size.width,
                                      child: TextFormField(
                                        controller: _confirm,
                                        style: textStyle,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return translation(context).confirm;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: translation(context).conformpassword,
                                          hintStyle:TextStyle(fontSize: 8.sp),
                                          contentPadding: EdgeInsets.only(left: 10.0,top: 5.0,bottom: 5.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                                            borderSide:const BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 1.h,),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      actions: [
                        buttonWidget(callback: (){

                          if(_formKey.currentState!.validate()){
                            if(_password.text.trim().toString()==_confirm.text.trim().toString()){
                                checkInternet().then((internet) async {
                                  if (internet) {
                                    signupprovider().changepass(_password.text.trim()).then((Response response) async {
                                      userData = UserModel.fromJson(jsonDecode(response.body));
                                      if (response.statusCode == 200 && userData?.status == "success"){
                                        await SaveDataLocal.saveLogInData(userData!);
                                        if (kDebugMode) {
                                          print(userData?.toJson().toString());
                                        }
                                        Fluttertoast.showToast(msg: translation(context).successfullylogin);
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>creataccount()));
                                      }
                                      else{
                                        buildErrorDialog(context, "",translation(context).userpassword);
                                      }
                                    });
                                    //     .catchError((onError) {
                                    //   setState(() {
                                    //     isLoading = false;
                                    //   });
                                    //   print('Eror ' + onError.toString());
                                    //   buildErrorDialog(context, 'Error', 'Something went wrong');
                                    // });
                                  } else {

                                    buildErrorDialog(context, 'Error',translation(context).internetrequired);
                                  }
                                });

                              }

                          }


                        }, width: 200.0, text: "Change Password"),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );

                   //  Navigator.of(context).pop();
                   // alertdialog(context);
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context)=>creataccount())
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
    ),
  );
}
alertdialog(context){
  TextEditingController _password=TextEditingController();
  TextEditingController _confirm=TextEditingController();
  // changepassapi()async{
  //   Map<String, String> data =<String,String> {};
  //   data["actionname"] = "change_reset_password";
  //   data["myNew_password"]= _password.text.trim().toString();
  //   print("object");
  //   // if(userData !=null){
    //   if(_password.text.toString()==_confirm.text.toString()){
    //     checkInternet().then((internet) async {
    //       if (internet) {
    //         signupprovider().changepass(data).then((Response response) async {
    //           userData = UserModel.fromJson(jsonDecode(response.body));
    //           // userData?.data!.registerPassword=data["myNew_password"];
    //           print(userData?.data!.registerPassword);
    //           if (response.statusCode == 200 && userData?.status == "success") {
    //             await SaveDataLocal.saveLogInData(userData!);
    //             print(userData!.toString());
    //             if (kDebugMode) {
    //               print(userData?.toJson().toString());
    //             }
    //             Fluttertoast.showToast(msg: "password  changed");
    //             Navigator.of(context).pop();
    //           }
    //           else {
    //             Fluttertoast.showToast(msg: "password not changed");
    //           }
    //         });
    //         // catchError((onError) {
    //         //   setState(() {
    //         //     isLoading = false;
    //         //   });
    //         //   buildErrorDialog(context, '', 'Something went wrong');
    //         // });
    //       }
    //     });
    //   }
    // }
    // else{
    //   buildErrorDialog(context, "", "please login for password change");
    // }

  }
  TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontFamily: "poppins",
    fontWeight: FontWeight.normal,
    fontSize: 11.sp,
  );

  // AlertDialog alert=AlertDialog(
  //   shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.all(Radius.circular(32.0))),
  //   contentPadding: EdgeInsets.all(10.0),
  //   title: Center(child: Text(translation(context).changepassword)),
  //   content: Row(
  //     // crossAxisAlignment: CrossAxisAlignment.start,
  //     // mainAxisAlignment:MainAxisAlignment.start ,
  //     children: [
  //       Container(
  //         height: 200.0,
  //         width: 70.w,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment:MainAxisAlignment.start ,
  //           children: [
  //             Text(translation(context).changepassword,style: TextStyle(fontSize: 10.sp),),
  //             SizedBox(height: 1.h,),
  //             Container(
  //               height: 4.h,
  //               width:MediaQuery.of(context).size.width,
  //               child: TextFormField(
  //                 controller: _password,
  //                 style: textStyle,
  //                 obscureText: true,
  //                 validator: (value) {
  //                   if (value!.isEmpty) {
  //                     return translation(context).enternewpassword;
  //                   }
  //                   return null;
  //                 },
  //                 decoration: InputDecoration(
  //                   hintText: translation(context).newpassword,
  //                   hintStyle:TextStyle(fontSize: 8.sp),
  //                   contentPadding: EdgeInsets.only(left: 10.0,top: 5.0,bottom: 5.0),
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.all(Radius.circular(10.sp)),
  //                     borderSide:const BorderSide(
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                   focusedBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.all(Radius.circular(10.sp)),
  //                     borderSide: const BorderSide(
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                 ),),
  //             ),
  //             SizedBox(height: 1.h,),
  //             Text(translation(context).conformpassword,style: TextStyle(fontSize: 10.sp),),
  //             SizedBox(height: 1.h,),
  //             Container(
  //               height: 5.h,
  //               width:MediaQuery.of(context).size.width,
  //               child: TextFormField(
  //                 controller: _confirm,
  //                 style: textStyle,
  //                 obscureText: true,
  //                 validator: (value) {
  //                   if (value!.isEmpty) {
  //                     return translation(context).confirm;
  //                   }
  //                   return null;
  //                 },
  //                 decoration: InputDecoration(
  //                   hintText: translation(context).conformpassword,
  //                   hintStyle:TextStyle(fontSize: 8.sp),
  //                   contentPadding: EdgeInsets.only(left: 10.0,top: 5.0,bottom: 5.0),
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.all(Radius.circular(10.sp)),
  //                     borderSide:const BorderSide(
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                   focusedBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.all(Radius.circular(10.sp)),
  //                     borderSide: const BorderSide(
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 1.h,),
  //             Container(
  //               height: 5.h,
  //               width:MediaQuery.of(context).size.width,
  //               child: TextButton(
  //                 style: ButtonStyle(
  //                   // alignment: Alignment.center,
  //                   backgroundColor: MaterialStateProperty.all(Colors.purple),
  //                   padding: MaterialStateProperty.all(
  //                     EdgeInsets.symmetric(vertical: 8.0),
  //                   ),
  //                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //                       RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10.sp),
  //                       )),
  //                 ),
  //                 onPressed: (){
  //
  //                 },
  //
  //                 child: Text(
  //                   translation(context).changepassword,
  //                   style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 10.sp,
  //                       fontFamily: "poppins",
  //                       fontWeight: FontWeight.normal
  //                   ),
  //                 ),),
  //             )
  //           ],
  //         ),
  //       )
  //     ],
  //   ),
  // );
  // showDialog(context: context, builder: (context){
  //   return alert;
  // });

// }

buildErrorDialog(BuildContext context,String title, String contant,
    {VoidCallback? callback, String? buttonname}) {
  Widget okButton = TextButton(
    child: Container(
      height: 40.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20.0),
          color:Colors.purple
      ),
      child: Center(
        child: Text(buttonname ?? 'OK',
            // textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                decorationColor: Colors.black,
                fontFamily: 'poppins')),
      ),
    ),
    onPressed: () {
      // if (callback == null) {
        Navigator.pop(context);
      // } else {

      // }
    },
  );

  if (Platform.isAndroid) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      titlePadding: EdgeInsets.all(0.0),
      contentPadding: EdgeInsets.only(top: 0.0,bottom: 0.0,left: 20.0),
      title: Text(title,
          style: const TextStyle(
              color: Colors.black,
              decorationColor: Colors.black,
              fontFamily: 'poppins')),
      content: Text(contant,
          style: const TextStyle(
              color: Colors.black,
              decorationColor: Colors.black,
              fontFamily: 'poppins')),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  if (Platform.isIOS) {
    CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
      title: Text(title,
          style: const TextStyle(
              color: Colors.black,
              decorationColor: Colors.black,
              fontFamily: 'poppins')),
      content: Text(contant,
          style: const TextStyle(
              color: Colors.black,
              decorationColor: Colors.black,
              fontFamily: 'poppins')),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return cupertinoAlertDialog;
      },
    );
  }
  // show the dialog
}










