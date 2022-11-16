import 'package:astrology2/classes/language_constant.dart';
import 'package:astrology2/utils/Widget.dart';
import 'package:astrology2/view/Progonsis.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Prognosisinfo extends StatefulWidget {
  const Prognosisinfo({Key? key}) : super(key: key);

  @override
  State<Prognosisinfo> createState() => _PrognosisinfoState();
}

class _PrognosisinfoState extends State<Prognosisinfo> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  List<bool> isCardEnabled = [];


  @override
  Widget build(BuildContext context) {
    List<String> _list = [
      translation(context).forcast,
      translation(context).sun,
      translation(context).moon,
      translation(context).marcury,
      translation(context).venus,
      translation(context).mars,
      translation(context).jupiter,
      translation(context).saturn,];
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
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Videobackground(),
            ),
            Container(
              padding: EdgeInsets.all(3.w),
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 15.h,),
                      Container(
                        alignment: Alignment.center,
                          height: 70.h,
                          width: 30.w,
                          // color: Colors.red,
                          child: GridView.builder(// padding: const EdgeInsets.all(15),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10
                              ),
                              itemCount: _list.length,
                              itemBuilder: (BuildContext context, int index) {
                                isCardEnabled.add(false);
                                return Container(
                                  height: 6.h,
                                  width: 20.w,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      // alignment: Alignment.center,
                                      backgroundColor: MaterialStateProperty
                                          .all(
                                          isCardEnabled[index]
                                              ? Colors.pink
                                              : Colors.purple
                                      ),
                                      padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(vertical: 8.0),
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            // borderRadius: BorderRadius.circular(0.0),
                                          )),
                                    ),
                                    onPressed: () {
                                      isCardEnabled.replaceRange(
                                          0, isCardEnabled.length, [
                                        for(int i = 0; i <
                                            isCardEnabled.length; i++)false
                                      ]);

                                      isCardEnabled[index] = true;
                                      setState(() {
                                        // isCardEnabled[index] = false;
                                        // print(_list[index].toString());
                                        // print(isCardEnabled[index]);
                                      });
                                    },
                                    child:
                                    Text(_list[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                );
                              })
                      ),
                    ],
                  ),
          SizedBox(width: 5.w,),
          Container(
            alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                width: 55.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(translation(context).information,textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,maxLines: 5,style:TextStyle(fontSize: 12.sp,color: Colors.white)),
                    SizedBox(height: 3.h,),
                    buttonWidget(callback: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Progonsis()));
                    },
                        width:55.w,
                        text: "xyz"),

                  ],
                )),

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
      )
    );
  }
}
