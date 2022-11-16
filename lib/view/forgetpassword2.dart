import 'package:astrology2/classes/language_constant.dart';
import 'package:astrology2/view/Progonsis.dart';
import 'package:astrology2/utils/Widget.dart';
import 'package:astrology2/view/login.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class forgetpassword2 extends StatefulWidget {
  const forgetpassword2({Key? key}) : super(key: key);

  @override
  State<forgetpassword2> createState() => _forgetpassword2State();
}

class _forgetpassword2State extends State<forgetpassword2> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  TextEditingController _password=TextEditingController();
  TextEditingController _confirm=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible=false;
  bool _passwordVisible1=false;
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
      body: Form(
        key: _formKey,
        child: Container(
          // height: double.infinity,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Videobackground(),
              ),
              Container(
                padding: EdgeInsets.all(3.w),
                child: Column(
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
                      child: Text(translation(context).enteryourpassword,style: TextStyle(color: Colors.white,
                          fontFamily: "poppins",
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp),),
                    ),
                    SizedBox(height: 1.h,),
                    Container(
                      // height: 9.h,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                          controller: _password,
                          style: textStyle,
                          obscureText: !_passwordVisible1,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return translation(context).enterpassword ;
                            }
                            return null;
                          },
                          decoration: inputDecoration(
                            icon1: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.purple.shade100,
                            ),
                            onclick: (){
                              setState(() {
                                _passwordVisible1 = !_passwordVisible1;
                              });
                            },
                            icon: Icon(Icons.lock,color: Colors.purple,),
                            hintText: translation(context).password,
                          )),
                    ),
                    SizedBox(height: 1.h,),
                    Container(
                      // height: 9.h,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                          controller: _confirm,
                          style: textStyle,
                          obscureText: !_passwordVisible,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return translation(context).repetpassword;
                            }
                            return null;
                          },
                          decoration: inputDecoration(
                            onclick: (){
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon1: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.purple.shade100,
                            ),
                            icon: Icon(Icons.lock,color: Colors.purple,),
                            hintText: translation(context).repetpassword,
                          )),
                    ),
                    SizedBox(height: 1.h,),
                    Padding(
                      // alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 2.w,right: 2.w,top: 1.w,bottom: 2.w),
                      child: buttonWidget(callback: (){
                        forgotpasswordapi();
                      }, width:200.0,
                          text:translation(context).reset),
                    ),
                  ],
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

    );
  }
  TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontSize: 12.sp,
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
  forgotpasswordapi(){
    if (_formKey.currentState!.validate()) {
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>login()));
      });
    }
  }
}
