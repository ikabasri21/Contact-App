import 'package:flutter/material.dart';
import 'constant.dart';
import 'halaman1.dart';
import 'package:dio/dio.dart';
import 'package:contact_app/signin_class.dart';

class HalamanDua extends StatefulWidget {
  const HalamanDua({Key? key}) : super(key: key);

  @override
  State<HalamanDua> createState() => _HalamanDuaState();
}

class _HalamanDuaState extends State<HalamanDua> {
  bool _PassVisibilityold = true;
  bool isTextEmpty = false;
  bool isTextEmpty2 = false;
  bool isTextEmpty3 = false;
  TextEditingController oldpasswordCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController passwordconfirmCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
            reverse: true,
            child: SafeArea(child:
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: MainBlue
                  ),
                  height: MediaQuery.of(context).size.height * 0.96,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                          top: 17,
                          left: 30,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return HalamanSatu();
                                  }));
                            },
                            child: Text (
                              'Sign In', style: TextStyle(
                                color: Colors.white, fontSize: 16,
                                fontFamily: 'Roboto', fontWeight: FontWeight.w400 ),),
                          )),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:<Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 56),
                              height: 324,
                              width: 330,
                              child: Image.asset('assets/images/logo_contact1.png'),
                            ),
                            SizedBox(height: 38,),
                            TextFormField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              onChanged: (value){
                                setState(() {
                                  if (value.isNotEmpty) {
                                    isTextEmpty = true;
                                  } else {
                                    isTextEmpty = false;
                                  }
                                }
                                );
                              },
                              controller: TextControl.nameController,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person,color: Colors.white,),
                                  hintText: 'Name', hintStyle: TextStyle(color: Colors.white),
                                  filled: true,
                                  fillColor: SecondBlue,
                                  border: InputBorder.none,
                                  constraints: BoxConstraints(maxHeight: 44, maxWidth: 307)

                              ),
                            ),
                            SizedBox(height: 12,),
                            TextFormField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              onChanged: (value){
                                setState(() {
                                  if (value.isNotEmpty) {
                                    isTextEmpty = true;
                                  } else {
                                    isTextEmpty = false;
                                  }
                                }
                                );
                              },
                              textInputAction: TextInputAction.done,
                              controller: TextControl.emailController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.mail_outline_sharp,color: Colors.white,),
                                  hintText: 'Email', hintStyle: TextStyle(color: Colors.white),
                                  filled: true,
                                  border: InputBorder.none,
                                  fillColor: SecondBlue,
                                  constraints: BoxConstraints(maxHeight: 44, maxWidth: 307)

                              ),
                            ),
                            SizedBox(height: 12,),
                            TextFormField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              onChanged: (value){
                                setState(() {
                                  if (value.isNotEmpty) {
                                    isTextEmpty = true;
                                  } else {
                                    isTextEmpty = false;
                                  }
                                }
                                );
                              },
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              controller: TextControl.passwordController,
                              obscureText: _PassVisibilityold,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock,color: Colors.white,),
                                  suffixStyle: TextStyle(fontSize: 14, color: Colors.white),
                                  hintText: 'Password', hintStyle: TextStyle(color: Colors.white),
                                  filled: true,
                                  border: InputBorder.none,
                                  fillColor: SecondBlue,
                                  constraints: BoxConstraints(maxHeight: 44, maxWidth: 307),
                                  suffixIcon: IconButton(onPressed: () {
                                    setState((){
                                      _PassVisibilityold = !_PassVisibilityold;
                                    });
                                  },
                                    icon: _PassVisibilityold
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                  )
                              ),
                            ),
                            SizedBox(height: 30,),
                            Container(
                              width: 320,
                              height: 55,
                              child: ElevatedButton(
                                /*onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context){
                                        return HalamanSatu();
                                      }
                                  )
                                  );
                                },*/
                                onPressed: () async {
                                  var dio = Dio();

                                  try {
                                    var options = dio.options;
                                    options.headers['Authorization'] = 'Bearer token';
                                    dio.options = options;
                                    var response = await dio.post(
                                      'https://phone-book-api.herokuapp.com/api/v1/signup',
                                      data: {
                                        "name": TextControl.nameController.text,
                                        "email": TextControl.emailController.text,
                                        "password": TextControl.passwordController.text
                                      }
                                    );
                                    print(response);

                                    String token = response.data['data'];
                                    print('Token: $token');

                                    if (token.isNotEmpty){
                                      print(options.headers);

                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context)
                                          {return const HalamanSatu();}));
                                    } else {
                                      print('Token tidak valid');
                                    };

                                  } catch (e, stackTrace) {
                                    print("Error: $e");
                                    print("Stack Trace: $stackTrace");
                                  }
                                },
                                child: Text("REGISTER",
                                  style: TextStyle(fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: MaterialStateColor.resolveWith((states) {
                                    if (isTextEmpty && isTextEmpty2 && isTextEmpty3)
                                    {
                                      return MagentaColor;
                                    } return MagentaColor;
                                  }
                                  ),
                                ),
                              ),
                            ),
                          ])
                    ],
                  ),
                )
              ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
