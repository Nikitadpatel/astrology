class UserModel {
  UserModel({
    String? status,
    Data? data,}){
    _status = status;
    _data = data;
  }
  UserModel.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  Data? _data;
  String? get status => _status;
  Data? get data => _data;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
Data({
  String? registerUsername,
  String? registerEmail,
  String? registerPassword,
  String? registerconfirmpassword,
})
{
  _registerUsername=registerUsername;
  _registerEmail=registerEmail;
 _registerPassword=registerPassword;
  _registerconfirmpassword= registerconfirmpassword;
}
  Data.fromJson(Map<String, dynamic> json) {
    _registerUsername = json['registerUsername'];
    _registerEmail = json['registerEmail'];
    _registerPassword = json['registerPassword'];
    _registerconfirmpassword = json['registerconfirmpassword'];
  }
String? _registerUsername;
String? _registerEmail;
String? _registerPassword;
String? _registerconfirmpassword;

String? get registerUsername=>_registerUsername;
    String? get registerEmail=>_registerEmail;
String?  get registerPassword=>_registerPassword;
    String? get  registerconfirmpassword=>_registerconfirmpassword;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['registerUsername'] = _registerUsername;
    map['registerEmail'] = _registerEmail;
    map['registerPassword'] = _registerPassword;
    map['registerconfirmpassword'] = _registerconfirmpassword;
    return map;
  }
}


