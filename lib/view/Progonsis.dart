import 'package:astrology2/classes/language_constant.dart';
import 'package:astrology2/view/Prognosisinfo.dart';
import 'package:astrology2/utils/Widget.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Progonsis extends StatefulWidget {
  const Progonsis({Key? key}) : super(key: key);

  @override
  State<Progonsis> createState() => _ProgonsisState();
}

class _ProgonsisState extends State<Progonsis> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();


  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
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
      body:  Container(

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
            Column(
              children: [

                SizedBox(height: 20.h,),
                  Container(
                    padding: EdgeInsets.all(2.w),
                alignment: Alignment.center,
                width:MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                Icon(Icons.location_on_outlined, color: Colors.white,),
                Text(translation(context).currentlocation,
                  style: TextStyle(fontSize: 12.sp, color: Colors.white),)
              ],
            ),
            SizedBox(height: 2.h,),
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CSCPicker(
                      layout: Layout.vertical,
                      showStates: true,
                      showCities: true,
                      flagState: CountryFlag.DISABLE,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                        color: Colors.white,
                      ),
                      disabledDropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                        color: Colors.white,
                      ),
                      countrySearchPlaceholder: translation(context).country,
                      stateSearchPlaceholder:  translation(context).state,
                      citySearchPlaceholder:  translation(context).city,
                      countryDropdownLabel:  translation(context).country,
                      stateDropdownLabel:  translation(context).state,
                      cityDropdownLabel:  translation(context).city,
                      selectedItemStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                      dropdownHeadingStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                      dropdownItemStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                      dropdownDialogRadius: 10.0,
                      searchBarRadius: 10.0,
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged: (String? value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value;
                        });
                      },
                    ),
                  ],
                )),
                    SizedBox(height: 2.h,),
            buttonWidget(callback: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Prognosisinfo ()));
            }, width: 60.w, text: translation(context).savedata)

          ],
                )
      )
              ],
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
    );
  }
  }

