import 'dart:convert';
import 'dart:io';
import 'package:astrology2/utils/CustomExpection.dart';
import 'package:astrology2/utils/response.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class signupprovider with ChangeNotifier{
  Map<String, String> headers = {

    'Authorization': 'hXuRUGsEGuhGf6KG',
  };

 Future<http.Response> signupapi(Map<String,String> bodyData) async {
   var body=jsonEncode(bodyData);
   const url = 'https://adibun.fableadtechnolabs.com/api/ajax.php/?actionname=signupform';
   var responseJson;

   try{
     var upload = await http.MultipartRequest('post', Uri.parse(url),);

     upload.headers.addAll(headers);
     upload.fields.addAll(bodyData);
     final streamResponse = await upload.send();
      print("hiiii");
     print(streamResponse);
     responseJson = responses( responses(await http.Response.fromStream(streamResponse)));
     print(responseJson);
   }
   on SocketException{
     throw FetchDataException('No Internet connection');
   }
   return responseJson;
 }

 Future<http.Response> loginapi(Map<String,String>bodyData) async {

      const url = 'https://adibun.fableadtechnolabs.com/api/ajax.php/?actionname=loginform';
      var responseJson;
      // var response = await http.post(Uri.parse(url),body: jsonEncode(bodyData),headers: headers);
      final response = await http.post(Uri.parse(url), body:bodyData , headers:headers )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw const SocketException('Something went wrong');
        },
      );
      responseJson = responses(response);
      return responseJson;
    }

Future<http.Response> changepass(password) async {

  const url = 'https://adibun.fableadtechnolabs.com/api/ajax.php/?actionname=change_reset_password';
  var responseJson;
  Map map = {
    'action': 'change_reset_password',
    "myNew_password": password ?? "",
  };

  final response = await http.post(Uri.parse(url), body:map , headers:headers )
      .timeout(
    const Duration(seconds: 30),
    onTimeout: () {
      throw const SocketException('Something went wrong');
    },
  );
  responseJson = responses(response);

  return responseJson;
}
  // Future<http.Response> dropdownapi(Map<String,String>bodyData) async {
  //
  //   const url = 'https://adibun.fableadtechnolabs.com/api/ajax.php/?actionname=fetch_language';
  //   var responseJson;
  //
  //   final response = await http.post(Uri.parse(url), body:bodyData , headers:headers )
  //       .timeout(
  //     const Duration(seconds: 30),
  //     onTimeout: () {
  //       throw const SocketException('Something went wrong');
  //     },
  //   );
  //   responseJson = responses(response);
  //   print("object");
  //   print(responseJson);
  //   return responseJson;
  // }



}




