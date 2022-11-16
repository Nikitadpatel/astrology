import 'package:astrology2/classes/language_constant.dart';
import 'package:astrology2/utils/Widget.dart';
import 'package:astrology2/view/forgetpassword2.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class forgetpassword extends StatefulWidget {


  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
              width: 100.0,
              child: dropdown(),
            ),

          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        // height: double.infinity,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Videobackground(),
                ),
               
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(3.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h,),
                        Container(
                        height: 40.h,
                        width: MediaQuery.of(context).size.width,

                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset("assets/password.jpg"))),
                        SizedBox(height: 1.h,),
                        Container(
                          width:MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Text(translation(context).enteryouremail,style: TextStyle(
                              color: Colors.white,fontSize: 12.sp,
                          fontFamily: "poppins",fontWeight: FontWeight.normal),),
                        ),
                        SizedBox(height: 2.h,),
                        Container(

                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
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
                                  return null;
                                }
                              }
                            },
                            decoration: inputDecoration(
                                icon: Icon(Icons.email,color:Colors.purple),
                                hintText: translation(context).email),
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        Center(
                            // padding:EdgeInsets.only(left: 20.w,right: 20.w),
                            child: buttonWidget(
                                callback: (){
                                    forgotemailapi();
                            }, width: 200.0, text: translation(context).submit),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  // top:80.0,
                  bottom: 0.h,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      child:Bottomnavigation()
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontSize: 12.sp,
  );

  InputDecoration inputDecoration({required String hintText,
    required Icon icon}) {
    return InputDecoration(
      fillColor: Colors.white,
      hoverColor: Colors.white,
      focusColor: Colors.white,
      filled: true,
      errorStyle:const TextStyle(
        color: Colors.red,
      ),
      hintText: hintText,
      prefixIcon: icon,
      prefixIconColor: Colors.purple,
      hintStyle: textStyle,
      contentPadding: EdgeInsets.only(top: 2.0,bottom: 2.0),
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
  forgotemailapi(){
    if (_formKey.currentState!.validate()) {
      void _contact() async {
        final url = 'mailto:nikitaptel.fablead@gmail.com';
        if (await canLaunch(url)) {

          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      }


    }

  }
}
