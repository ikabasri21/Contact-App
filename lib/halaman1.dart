import 'package:contact_app/constant.dart';
import 'package:contact_app/mycontact.dart';
import 'package:contact_app/signin_class.dart';
import 'package:flutter/material.dart';
import 'halaman2.dart';
import 'package:dio/dio.dart';

class HalamanSatu extends StatefulWidget {
  const HalamanSatu({Key? key}) : super(key: key);

  @override
  State<HalamanSatu> createState() => _HalamanSatuState();
}

class _HalamanSatuState extends State<HalamanSatu> {
  bool _PassVisibilityold = true;
  bool isTextEmpty = false;
  bool isTextEmpty2 = false;
  bool isTextEmpty3 = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(color: MainBlue),
                    height: MediaQuery.of(context).size.height * 0.96,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                            top: 17,
                            right: 15,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HalamanDua();
                                }));
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400),
                              ),
                            )),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 56),
                                height: 324,
                                width: 330,
                                child: Image.asset(
                                    'assets/images/logo_contact1.png'),
                              ),
                              SizedBox(
                                height: 38,
                              ),
                              Container(
                                width: 320,
                                height: 55,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.isNotEmpty) {
                                        isTextEmpty = true;
                                      } else {
                                        isTextEmpty = false;
                                      }
                                    });
                                  },
                                  textInputAction: TextInputAction.done,
                                  controller: TextControl.emailController,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.mail_outline_sharp,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Email',
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: SecondBlue,
                                      constraints: BoxConstraints(
                                          maxHeight: 44, maxWidth: 307)),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                          Container(
                            width: 320,
                            height: 55,
                            child: TextFormField(
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
                                    prefixIcon: Icon(Icons.lock_outline, color: Colors.white,),
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle: TextStyle(color: Colors.white),
                                    filled: true,
                                    fillColor: SecondBlue,
                                    constraints: BoxConstraints(
                                        maxHeight: 44, maxWidth: 307),
                                    suffixIcon: IconButton(onPressed: () {
                                      setState((){
                                        _PassVisibilityold = !_PassVisibilityold;
                                      });
                                    },
                                      icon: _PassVisibilityold
                                          ? const Icon(Icons.visibility_off)
                                          : const Icon(Icons.visibility),
                                    ))),
                          ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: 320,
                                height: 55,
                                child: ElevatedButton(
                                  /*onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context){
                                          return MyContact();
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
                                        'https://phone-book-api.herokuapp.com/api/v1/signin',
                                        data: {
                                          "email": TextControl.emailController.text,
                                          "password": TextControl.passwordController.text,
                                        },
                                      );

                                      String token = response.data['data']['token'] ?? '';
                                      print('Token: $token');

                                      TextControl.token= token;

                                      if (token.isNotEmpty){
                                        print(options.headers);

                                      } else {
                                        print('Token tidak valid');
                                      };
                                      options.headers['Authorization'] = 'Bearer $token';
                                      dio.options = options;
                                      try {
                                        var response = await dio.get(
                                          'https://phone-book-api.herokuapp.com/api/v1/contacts',
                                        );

                                        Data.listKontak = response.data['data'];
                                        Data.listKontak.sort((a,b) => a['name'].compareTo(b['name']));

                                      } catch (e, stackTrace) {
                                        print('Error: $e');
                                        print('Stack Trace: $stackTrace');
                                      }
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (_) => MyContact()));

                                    } catch (e, stackTrace) {
                                      print("Error: $e");
                                      print("Stack Trace: $stackTrace");
                                    }
                                    },
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: MaterialStateColor.resolveWith(
                                        (states) {
                                      if (isTextEmpty &&
                                          isTextEmpty2 &&
                                          isTextEmpty3) {
                                        return MagentaColor;
                                      }
                                      return MagentaColor;
                                    }),
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
