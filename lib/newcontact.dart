import 'package:contact_app/mycontact.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'contactdetail.dart';
import 'package:contact_app/signin_class.dart';
import 'package:dio/dio.dart';

class NewContact extends StatelessWidget {

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
          SafeArea(
              child: SingleChildScrollView(
                  reverse: true,
                  child:
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                                onPressed: (){
                                  // Navigate back to first route when tapped.
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => MyContact(),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.arrow_back_rounded, size: 30,)),
                            Text('Back', style: TextStyle(fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w600),)
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey),
                          alignment: Alignment.center,
                          height: 186,
                          width: 184,
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.person_rounded, size: 150, color: Colors.black,),
                        ),
                        SizedBox(height:40),
                        Container(
                          height: 55,
                          width: 320,
                          child: TextField(
                              controller: TextControl.name2Controller,
                              decoration:
                              InputDecoration(
                                  filled: true ,
                                  fillColor: Colors.grey,
                                  labelText: 'Name',
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.person_rounded), prefixIconColor: Colors.black)
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 55,
                          width: 320,
                          child: Row(children: [
                            Container(
                              height: 55,
                              width: 155,
                              child: TextField(
                                  controller: TextControl.phoneController,
                                  decoration:
                                  InputDecoration(
                                    filled: true ,
                                    border: InputBorder.none,
                                    fillColor: Colors.grey,
                                    labelText: '+62   Phone',)
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 55,
                              width: 155,
                              child: TextField(
                                  controller: TextControl.email2Controller,
                                  decoration:
                                  InputDecoration(
                                      filled: true ,
                                      fillColor: Colors.grey,
                                      labelText: 'Email',
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.mail_outline_sharp), prefixIconColor: Colors.black)
                              ),
                            ),
                          ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        Container(
                            height: 55,
                            width: 320,
                            child: Row(children: [
                              Container(
                                height: 55,
                                width: 155,
                                child: TextField(
                                    controller: TextControl.companyController,
                                    decoration:
                                    InputDecoration(
                                        filled: true ,
                                        fillColor: Colors.grey,
                                        labelText: 'Company',
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.assured_workload), prefixIconColor: Colors.black)
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: 55,
                                width: 155,
                                child: TextField(
                                    controller: TextControl.jobController,
                                    decoration:
                                    InputDecoration(
                                        filled: true ,
                                        fillColor: Colors.grey,
                                        labelText: 'Job',
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.build), prefixIconColor: Colors.black)
                                ),
                              ),],
                            )),
                        SizedBox(height: 40,),
                        Container(
                          width: 320,
                          height: 55,
                          child: ElevatedButton(
                            /*onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return ContactDetail();
                          }
                      )
                      );
                    },*/
                            onPressed: () async {
                              var dio = Dio();

                              try {
                                var token = TextControl.token;
                                var options = dio.options;
                                options.headers['Authorization'] = 'Bearer $token';
                                dio.options = options;
                                var response = await dio.post(
                                    'https://phone-book-api.herokuapp.com/api/v1/contacts',
                                    data: {
                                      "name": TextControl.name2Controller.text,
                                      "phone": TextControl.phoneController.text,
                                      "email": TextControl.email2Controller.text,
                                      "company": TextControl.companyController.text,
                                      "job": TextControl.jobController.text
                                    }
                                );
                                print(response);

                                //String token = response.data['data'];
                                print('Token: $token');

                                if (token != null){
                                  print(options.headers);

                                } else {
                                  print('Token tidak valid');
                                };

                                options.headers['Authorization'] = 'Bearer $token';
                                dio.options = options;

                                try{
                                  var response = await dio.get(
                                      'https://phone-book-api.herokuapp.com/api/v1/contacts');

                                  Data.listKontak = response.data['data'];
                                  Data.listKontak.sort((a,b) => a['name'].compareTo(b['name']));

                                } catch (e, stackTrace) {
                                  print("Error: $e");
                                  print("Stack Trace: $stackTrace");
                                }
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context)
                                    {return MyContact();}));
                              }

                              catch (e, stackTrace) {
                                print("Error: $e");
                                print("Stack Trace: $stackTrace");
                              }},
                            child: Text(
                              "CREATE NEW ACCOUNT",
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
                      ])))],
      ),
    );
  }
}
