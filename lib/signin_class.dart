import 'package:flutter/material.dart';

class TextControl {
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController name2Controller = TextEditingController();
  static final TextEditingController phoneController = TextEditingController();
  static final TextEditingController email2Controller = TextEditingController();
  static final TextEditingController companyController = TextEditingController();
  static final TextEditingController jobController = TextEditingController();
  static final TextEditingController name3Controller = TextEditingController();
  static final TextEditingController phone3Controller = TextEditingController();
  static final TextEditingController email3Controller = TextEditingController();
  static final TextEditingController company3Controller = TextEditingController();
  static final TextEditingController job3Controller = TextEditingController();
  static String? token;
}

class Data {
  List<String> listKontakOnSearch =[];
  static List<dynamic> listFavorite =[];
  static List<dynamic> listKontak =[];
  static List<dynamic> listRecent =[];
  static Map <String,dynamic>? contactInfo;
}