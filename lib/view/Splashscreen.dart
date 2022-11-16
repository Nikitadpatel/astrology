import 'package:astrology2/classes/language_constant.dart';
import 'package:astrology2/utils/Widget.dart';
import 'package:astrology2/utils/const.dart';
import 'package:astrology2/utils/sharepreferance.dart';
import 'package:astrology2/view/login.dart';
import 'package:astrology2/view/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
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
              width: 125.0,
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
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Videobackground(),
              ),
              SingleChildScrollView(
                child:Container(
                  padding: EdgeInsets.all(3.w),
                  child:Column(
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
                      Container(
                        // padding: EdgeInsets.all(2.w),
                        width: MediaQuery.of(context).size.width,
                        child:Column(
                          children: [
                            Text(translation(context).about,
                              style: textStyle, textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 7,),
                            RichText(
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 7,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: translation(context).about1,
                                      style: textStyle),
                                  WidgetSpan(
                                    child: GestureDetector(
                                      child: Text(
                                        'https://www.facebook.com/groups/460216205876520',
                                        style: TextStyle(
                                            fontFamily: "poppins",
                                            color: Colors.blue,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      onTap: () async {
                                        var url = "https://www.facebook.com/groups/460216205876520 ";

                                        if (await canLaunch(url)) {
                                          await launch( url, universalLinksOnly: true,
                                              forceSafariVC: false,
                                              forceWebView: true,
                                              enableJavaScript: true);
                                        }
                                        else {
                                          throw 'There was a problem to open the url: $url';
                                        }
                                      },
                                    ),
                                  ),
                                  TextSpan(
                                      text: translation(context).about2,

                                      style:textStyle,),
                                  WidgetSpan(
                                    child: GestureDetector(
                                      child: Text(
                                        'adibun.astrolog@gmail.com',
                                        style: TextStyle(
                                            fontFamily: "poppins",
                                            color: Colors.blue,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      onTap: () async {
                                        String email = Uri.encodeComponent("adibun.astrolog@gmail.com");
                                        String subject = Uri.encodeComponent("");
                                        String body = Uri.encodeComponent("");
                                        print(subject); //output: Hello%20Flutter
                                        Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
                                        if (await launchUrl(mail)) {
                                          //email app opened
                                        }else{
                                          //email app is not opened
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h,),
                      Padding(
                        // alignment: Alignment.center,
                        padding: EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment:CrossAxisAlignment.center ,
                          children: [
                            buttonWidget(callback: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>login()));
                            }, width:40.w, text:translation(context).login1),
                            buttonWidget(callback: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>signup()));
                            }, width: 40.w, text: translation(context).signup)
                          ],
                        ),
                      ),
                      SizedBox(height: 7.h,),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    child:Bottomnavigation()
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  TextStyle textStyle = TextStyle(
    fontFamily: "poppins",
    color: Colors.white,
    fontSize: 10.sp,
    fontWeight: FontWeight.normal
  );
}
