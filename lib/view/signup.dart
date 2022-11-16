import 'dart:convert';
import 'package:astrology2/classes/language_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:astrology2/models/UserModel.dart';
import 'package:astrology2/provider/signupprovider.dart';
import 'package:astrology2/utils/Widget.dart';
import 'package:astrology2/utils/const.dart';
import 'package:astrology2/utils/sharepreferance.dart';
import 'package:astrology2/view/creataccount.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  TextEditingController _user = TextEditingController();
  TextEditingController _confirm = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool? select = false;
  bool isLoading = false;
  bool? _passwordVisible = false;
  bool? _passwordVisible1 = false;

  final _formKey = GlobalKey<FormState>();

  void initState() {
    _passwordVisible = false;
    _passwordVisible1 = false;
    bool? select = false;
  }

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
              width: 150.0,
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
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: video(),
                        ),
                      ),
                      SizedBox(height: 2.h,),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 8.h,
                          width: 8.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset("assets/facebook.png",
                            fit: BoxFit.cover,),
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      Row(children: <Widget>[
                        Expanded(
                          child: Container(
                            // margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                              child: Divider(
                                thickness: 2.0,
                                color: Colors.white,
                                height: 36,
                              )),
                        ),
                        Text(translation(context).or, style: TextStyle(color: Colors.white),),
                        Expanded(
                          child: Container(
                            // margin: co EdgeInsets.only(left: 20.0, right: 10.0),
                              child: Divider(
                                thickness: 2.0,
                                color: Colors.white,
                                height: 36,
                              )),
                        ),
                      ]),
                      SizedBox(height: 2.h,),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child:
                        TextFormField(
                          textAlign: TextAlign.left,
                          controller: _user,
                          style: textStyle,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return translation(context).entrname;
                            }
                            return null;
                          },
                          decoration: inputDecoration(
                            onclick: () {},
                            icon1: Icon(null),
                            icon: Icon(Icons.person, color: Colors.purple,),
                            hintText: translation(context).name,
                          ),
                        ),

                      ),
                      SizedBox(height: 2.h,),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
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
                           return null;
                            }
                          },
                          decoration: inputDecoration(
                              onclick: () {},
                              icon1: Icon(null),
                              icon: Icon(Icons.email, color: Colors.purple),
                              hintText: translation(context).email),
                        ),
                      ),
                      SizedBox(height: 2.h,),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: TextFormField(
                            obscureText: _passwordVisible!,
                            controller: _password,
                            style: textStyle,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return translation(context).enterpassword;
                              }
                              return null;
                            },
                            decoration: inputDecoration(
                              onclick: () {
                                setState(() {
                                  _passwordVisible = _passwordVisible!;
                                });
                              },
                              icon1: Icon(
                                _passwordVisible!
                                    ? Icons.visibility
                                    : Icons.visibility_off,),
                              icon: Icon(Icons.lock, color: Colors.purple,),
                              hintText:translation(context).password,
                            )),
                      ),
                      SizedBox(height: 2.h,),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: TextFormField(
                            controller: _confirm,
                            style: textStyle,
                            obscureText: _passwordVisible1!,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return translation(context).repetpassword;
                              }
                              return null;
                            },
                            decoration: inputDecoration(
                              onclick: () {
                                setState(() {
                                  _passwordVisible1 = !_passwordVisible1!;
                                });
                              },
                              icon1: Icon(
                                _passwordVisible1!
                                    ? Icons.visibility
                                    : Icons.visibility_off,),
                              icon: Icon(Icons.lock, color: Colors.purple,),
                              hintText: translation(context).repetpassword,
                            )),
                      ),
                      SizedBox(height: 1.h,),
                      Row(
                        children: [
                          Expanded(
                            flex:1,
                            child: Checkbox(value: select,
                                onChanged: (val) {
                                  setState(() {
                                    select = val;
                                  });
                                  print(select.toString());
                                }),
                          ),
                          Expanded(
                            flex: 10,
                            child: Text(translation(context).condition,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),),
                          )
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      buttonWidget(callback: () {
                        signupApi();
                      },
                          width: 150,
                          text: translation(context).creataccount),
                      SizedBox(height: 7.h,),
                    ],
                  ),
                ),
              ),
              Positioned(
                // top:80.0,
                bottom: 0.h,
                child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 50.0,
                    child: Bottomnavigation()
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
      fillColor: Colors.white,
      hoverColor: Colors.white,
      focusColor: Colors.white,
      filled: true,
      errorStyle: const TextStyle(
        color: Colors.red,
      ),

      hintText: hintText,
      prefixIcon: icon,
      suffixIcon: IconButton(
        onPressed: onclick,
        icon: icon1,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 2.0),
      prefixIconColor: Colors.purple,
      hintStyle: textStyle,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.sp)),
        borderSide: const BorderSide(
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

  signupApi() async {
    Map<String, String> data =<String,String> {};
      data["actionname"] = "signupform";
      data["registerUsername"]= _user.text.trim().toString();
      data["registerEmail"]= _email.text.trim().toString();
      data["registerPassword"]= _password.text.trim().toString();
     data ["registerconfirmpassword"]= _confirm.text.trim().toString();

    if(select==true){
      if (_password.text.trim().toString() == _confirm.text.trim().toString()) {
        if (_formKey.currentState!.validate()) {
          setState(() {});
        }
        checkInternet().then((internet) async {
          if (internet) {
              signupprovider().signupapi(data).then((Response response) async {

                userData = UserModel.fromJson(json.decode(response.body));
                print("0101");
                print(userData?.data?.registerUsername.toString());
                if (response.statusCode == 200 && userData?.status == "User exist") {
                  setState(() {
                    isLoading = false;
                  });
                  await SaveDataLocal.saveLogInData(userData!);
                  if (kDebugMode) {

                  }
                  buildErrorDialog(
                      context, "", translation(context).checkemail);
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => creataccount()));
                }
              });
            // catchError((onError) {
            //   setState(() {
            //     isLoading = false;
            //   });
            //   buildErrorDialog(context, '', 'Something went wrong');
            // });
                }
          else {
            setState(() {
              isLoading = false;
            });
            buildErrorDialog(context, 'Error', translation(context).internetrequired);
          }
            });

      }
      else {
        buildErrorDialog(
            context, '', translation(context).same);
      }
    }
    else {
      buildErrorDialog(
          context, '', translation(context).checked);
    }
  }
}
