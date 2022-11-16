import 'package:astrology2/classes/language_constant.dart';
import 'package:astrology2/utils/Widget.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class creataccount extends StatefulWidget {
  const creataccount({Key? key}) : super(key: key);

  @override
  State<creataccount> createState() => _creataccountState();
}

class _creataccountState extends State<creataccount> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  TextEditingController _fname=TextEditingController();
  TextEditingController _lname=TextEditingController();
  TextEditingController _date=TextEditingController();
  TextEditingController _time=TextEditingController();
  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  var select=true;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _date.text = "";
    _time.text = "";//set the initial value of text field
    super.initState();

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
        //
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
                      Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(translation(context).birthtimeandplace,style: TextStyle(color: Colors.white,
                              fontSize: 20.sp,fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      Container(
                        alignment: Alignment.center,
                        height: 1.sp,
                        width: 180.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 2.h,),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.person,color: Colors.white,),
                                  Text(translation(context).fname,style: textStyle1,)
                                ],
                              ),
                              Container(
                                width:45.w,
                                child: TextFormField(
                                  controller: _fname,
                                  style: textStyle,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return translation(context).enterfname;
                                    }
                                    return null;
                                  },
                                  decoration:inputDecoration(
                                    icon:Icon(null),
                                    hintText: translation(context).fname,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 4.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.person,color: Colors.white,),
                                  Text(translation(context).lname,style: textStyle1,)
                                ],
                              ),
                              Container(
                                width:45.w,
                                child: TextFormField(
                                  controller: _lname,
                                  style: textStyle,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return translation(context).enterlname;
                                    }
                                    return null;
                                  },
                                  decoration:inputDecoration(
                                    icon: Icon(null),
                                    hintText: translation(context).lname,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h,),
                      Row(
                        children: [
                          Icon(Icons.calendar_month_outlined,color: Colors.white,),
                          Text(translation(context).enterbirth,style: textStyle1,),
                        ],
                      ),
                      Container(
                        width:MediaQuery.of(context).size.width,
                        child:TextFormField(
                          controller: _date,
                          readOnly: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return translation(context).selectbirthday;
                            }
                            return null;
                          },
                          onTap: ()async{
                            DateTime? pickedDate = await showDatePicker(
                                context: context, initialDate: DateTime.now(),
                                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );
                            if(pickedDate!= null ){
                              print(pickedDate);
                              String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                              print(formattedDate);
                              setState(() {
                                _date.text = formattedDate; //set output date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }
                          },
                          decoration: inputDecoration(hintText: translation(context).birthday,
                              icon: Icon(Icons.calendar_month_outlined,color: Colors.black,)),
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      Row(
                        children: [
                          Icon(Icons.lock_clock,color: Colors.white,),
                          Text(translation(context).entertime,style: textStyle1,),
                        ],
                      ),
                      Container(
                        width:MediaQuery.of(context).size.width,
                        child:TextFormField(
                          controller: _time, //editing controller of this TextField
                          readOnly: true,  //set it true, so that user will not able to edit text
                          validator: (value) {
                            if (value!.isEmpty) {
                              return translation(context).selectbirthtime;
                            }
                            return null;
                          },
                          onTap: () async {
                            TimeOfDay? pickedTime =  await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );
                            if(pickedTime != null ){
                              print(pickedTime.format(context));   //output 10:51 PM
                              setState(() {
                                _time.text = pickedTime.format(context).toString(); //set the value of text field.
                              });
                            }else{
                              print("Time is not selected");
                            }
                          },
                          decoration: inputDecoration(hintText: translation(context).birthtime,
                              icon: Icon(Icons.lock_clock,color: Colors.black,)),
                        ),
                      ),
                      SizedBox(height: 1.h,),
                   Row(
                  children: [
                    Icon(Icons.location_on_outlined,color: Colors.white,),
                    Text(translation(context).place,style: textStyle1,),
                  ],
                ),
                  Container(
                      child: Column(
                        children: [

                          CSCPicker(
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
                            stateSearchPlaceholder: translation(context).state,
                            citySearchPlaceholder: translation(context).city,
                            countryDropdownLabel: translation(context).country,
                            stateDropdownLabel: translation(context).state,
                            cityDropdownLabel: translation(context).city,
                            selectedItemStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
                            ),
                            dropdownHeadingStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold),
                            dropdownItemStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
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
                      SizedBox(height: 1.h,),
                      Padding(
                        // alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 2.w,right: 2.w,top: 1.w,bottom: 2.w),
                        child: buttonWidget(callback: (){
                          creataccountapi();
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>creataccount()));
                        }, width:200.0,
                            text: translation(context).update),
                      ),
                      SizedBox(height: 7.h,)
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
    color: Colors.black,
    fontSize: 10.sp,
  );
  TextStyle textStyle1 = TextStyle(
    color: Colors.white,
    fontSize: 10.sp,
  );

  InputDecoration inputDecoration({required String hintText,
   required Icon icon }) {
    return InputDecoration(
      fillColor: Colors.white,
      hoverColor: Colors.white,
      focusColor: Colors.white,
      filled: true,
      suffixIcon: icon,
      errorStyle:const TextStyle(
        color: Colors.red,
      ),
      hintText: hintText,
      contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 10.0),
      hintStyle: textStyle,
      // contentPadding: EdgeInsets.all(5.w),
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
  creataccountapi()async{
    if (_formKey.currentState!.validate()) {
      setState(() {

      });
    }

  }
}
