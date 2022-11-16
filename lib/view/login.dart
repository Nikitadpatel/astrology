import 'dart:convert';
import 'package:astrology2/classes/language_constant.dart';
import 'package:http/http.dart' as http;
import 'package:astrology2/models/UserModel.dart';
import 'package:astrology2/provider/signupprovider.dart';
import 'package:astrology2/utils/Widget.dart';
import 'package:astrology2/utils/const.dart';
import 'package:astrology2/utils/sharepreferance.dart';
import 'package:astrology2/view/creataccount.dart';
import 'package:astrology2/view/forgetpassword.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible=false;
  bool   isLoading = false;
  @override
 /* void initState() {
    setState(() {
      select = Language.languageList().first.languageCode;
    });
    _passwordVisible = false;
  }*/


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldState,
      extendBodyBehindAppBar: true,
    drawer: Drawerwidget(context),
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _scaffoldState.currentState?.openDrawer();
              },
              child: Container(
                // margin: EdgeInsets.only(left: 2.w,right: 90.w,top:0.w),
                child: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
              width: 140.0,
              child: dropdown(),
            ),

          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
          key: _formKey,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Videobackground(),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  child: Column(
                    children: [
                       SizedBox(height: 10.h,),
                       Container(
                         height: 38.h,
                         width: MediaQuery.of(context).size.width,
                         child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: video(),
                      ),
                       ),
                      SizedBox(height: 1.h,),
                      GestureDetector(
                              onTap: (){},
                              child: Container(
                                height: 8.h,
                                width: 8.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset("assets/facebook.png",fit: BoxFit.cover,),
                              ),
                         ),
                      SizedBox(height: 1.h,),
                      Row(children: <Widget>[
                        Expanded(
                          child:  Container(
                              // margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                              child: Divider(
                                thickness: 2.0,
                                color: Colors.white,
                                height: 36,
                              )),
                        ),
                        Text(translation(context).or,style: TextStyle(color: Colors.white),),
                        Expanded(
                          child:  Container(
                              // margin: co EdgeInsets.only(left: 20.0, right: 10.0),
                              child: Divider(
                                thickness: 2.0,
                                color: Colors.white,
                                height: 36,
                              )),
                        ),
                      ]),
                      SizedBox(height: 1.h,),
                      Container(

                        width: MediaQuery.of(context).size.width,
                        // padding: EdgeInsets.all(1.h),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _email,
                          style: textStyle,
                          validator: (value) {
                            String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                                "\\@" +
                                "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                                "(" +
                                "\\." +
                                "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                                ")+";
                            //Convert string p to a RegEx
                            RegExp regExp = RegExp(p);
                            if (value!.isEmpty) {
                              return translation(context).enteremail;
                            } else {
                              //If email address matches pattern
                              if (regExp.hasMatch(value)) {
                                return null;
                              } else {
                                //If it doesn't match
                                return translation(context).invalide;
                              }
                            }
                          },
                          decoration: inputDecoration(
                              onclick: (){},
                              icon1: Icon(null),
                              icon: Icon(Icons.email,color:Colors.purple),
                              hintText: translation(context).email),
                        ),
                      ),
                      SizedBox(height: 2.h,),
                      Container(

                        width: MediaQuery.of(context).size.width,
                        // padding: EdgeInsets.all(1.h),
                        child: TextFormField(
                            controller: _password,
                            style: textStyle,
                            obscureText: !_passwordVisible,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return translation(context).enterpassword;
                              }
                              return null;
                            },
                            decoration: inputDecoration(
                              onclick: (){
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                              icon1:Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,color: Colors.purple.shade100,),
                              icon: Icon(Icons.lock,color: Colors.purple,),
                              hintText: translation(context).password,
                            )),
                      ),
                      SizedBox(height: 1.h,),
                      Container(
                        alignment: Alignment.centerRight,
                        // padding:EdgeInsets.only(right: 2.w,left: 60.w),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>forgetpassword()));
                          },
                          child: Text(
                            translation(context).forgotpassword,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 11.sp),
                          ),
                        ),
                      ),
                      SizedBox(height:1.h,),
                      Padding(
                        // alignment: Alignment.center,
                        padding: EdgeInsets.all(0.0),
                        child: buttonWidget(callback: (){
                          loginApi();

                        }, width:200.0,
                            text: translation(context).login),
                      ),
                      SizedBox(height:7.h),
                    ],
                  ),
                ),

              ),
              Positioned(
                  bottom:0.0,
                  child:  Container(
                // padding: EdgeInsets.only(top:1.h),
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child:Bottomnavigation()
              ))
            ],
          ),
        ),

    );
  }
  TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontSize: 10.sp,
  );

  InputDecoration inputDecoration({required String hintText,
    required VoidCallback onclick,
    required Icon icon1,
  required Icon icon}) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 2.0),
      fillColor: Colors.white,
      hoverColor: Colors.white,
      focusColor: Colors.white,
      filled: true,
      errorStyle:const TextStyle(
        color: Colors.red,
      ),
      hintText: hintText,
      prefixIcon: icon,
      suffixIcon: IconButton(
        onPressed: onclick,
        icon: icon1,
      ),
      prefixIconColor: Colors.purple,
      hintStyle: textStyle,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.sp)),
        borderSide:const BorderSide(
          color: Colors.black,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.sp)),
        borderSide: const BorderSide(
          color: Colors.black,
        ),
      ),
    );
  }
  loginApi()async {
    if (_formKey.currentState!.validate()) {
     setState(() {
     });
     final Map<String, String> data = {
     };

     data['loginName'] = _email.text.trim().toString();
     data['loginPassword'] = _password.text.trim().toString();
     data['actionname'] = 'loginform';
     Map<String, String> headers = {
       'Authorization': 'hXuRUGsEGuhGf6KG',
     };
     checkInternet().then((internet) async {
       if (internet) {
         signupprovider().loginapi(data).then((Response response) async {
           userData = UserModel.fromJson(jsonDecode(response.body));
           print("hiii");
           print(userData?.data.toString());
           if (response.statusCode == 200 && userData?.status == "success") {
             setState(() {
               isLoading = false;
             });
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
         setState(() {
           isLoading = false;
         });
         buildErrorDialog(context, 'Error',translation(context).internetrequired);
       }
     });
    }
      }

}
