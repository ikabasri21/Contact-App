import 'package:contact_app/mycontact.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'mycontact.dart';
import 'package:dio/dio.dart';
import 'package:contact_app/signin_class.dart';

class  ContactDetail extends StatefulWidget {
  final id;
  // const EditContact ({Key? key}) : super(key: key);
  ContactDetail(this.id);
  @override
  State<ContactDetail>  createState() => _ContactDetailState();
}
class _ContactDetailState extends State<ContactDetail> {

  bool isTextEmpty = false;
  bool isTextEmpty2 = false;
  bool isTextEmpty3 = false;
  TextEditingController passwordCon = TextEditingController();

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
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                          alignment: Alignment.center,
                          height: 186,
                          width: 184,
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.person_rounded, size: 150, color: Colors.black,),
                        ),
                        SizedBox(height:15),
                        Text(TextControl.nameController.text, style: TextStyle(fontSize: 20),),
                        SizedBox(height:40),
                        Container(
                          padding: EdgeInsets.only(left: 70),
                          child: Column( mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                            Row(children: <Widget>[
                              Icon(Icons.phone),
                              SizedBox(width: 20,),
                              Text(TextControl.phoneController.text, style: TextStyle(fontSize: 16))
                            ],),
                            SizedBox(height:20),
                            Row(children: <Widget>[
                              Icon(Icons.assured_workload),
                              SizedBox(width: 20,),
                              Text(TextControl.companyController.text, style: TextStyle(fontSize: 16))
                            ],),
                            SizedBox(height:20),
                            Row(children: <Widget>[
                              Icon(Icons.build),
                              SizedBox(width: 20,),
                              Text(TextControl.jobController.text, style: TextStyle(fontSize: 16))
                            ],),
                            SizedBox(height:20),
                            Row(children: <Widget>[
                              Icon(Icons.mail_outline_sharp),
                              SizedBox(width: 20,),
                              Text(TextControl.emailController.text, style: TextStyle(fontSize: 16))
                            ],),
                          ],),
                        )
                      ])))],
      ),
    );
  }
}
