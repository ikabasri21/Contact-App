import 'package:contact_app/contactdetail.dart';
import 'package:contact_app/favorite.dart';
import 'package:contact_app/newcontact.dart';
import 'package:contact_app/recent.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'package:contact_app/signin_class.dart';
import 'editcontact.dart';
import 'package:dio/dio.dart';

class MyContact extends StatefulWidget {
  //const ({Key? key}) : super(key: key);

  @override
  State<MyContact> createState() => _MyContactState();
}

class _MyContactState extends State<MyContact> {
  TextEditingController? _textEditingController = TextEditingController();
  Color _iconColor = Colors.black;
  var dio = Dio();
  void refresh () async {
    dio.options.headers['Authorization'] =
    'Bearer ${TextControl.token}';
    try {
      var response = await dio.get(
        'https://phone-book-api.herokuapp.com/api/v1/contacts',
      );
      Data.listKontak = response.data['data'];
      Data.listKontak.sort((a, b) => a['name'].compareTo(b['name']));
      setState(() {
      });
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack Trace: $stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SafeArea(
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "My Contact",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Spacer(),
                          IconButton(
                            icon: const Icon(Icons.add_circle_rounded,
                                color: Colors.black),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return NewContact();
                              }));
                            },
                          ),
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 44,
                width: 340,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6), color: Colors.grey),
                child: Container(
                  child: TextField(
                    onChanged: (value){},
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        hintText: 'Search contact',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.black,
                        ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(
                  'A',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 14),
                ),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 15, left: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 480,
                width: 350,
                //decoration: BoxDecoration(color: Colors.blue),
                child: ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < Data.listKontak.length; i++)
                          GestureDetector(
                            onTapUp: (value) async {
                              TextControl.nameController.text=Data.listKontak[i]['name'];
                              TextControl.phoneController.text=Data.listKontak[i]['phone'];
                              TextControl.emailController.text=Data.listKontak[i]['email'];
                              TextControl.companyController.text=Data.listKontak[i]['company'];
                              TextControl.jobController.text=Data.listKontak[i]['job'];
                              Data.listRecent.add(Data.listKontak[i]);
                              await Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => ContactDetail(Data.listKontak[i]['id'])));

                              },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                    Icons.account_circle_rounded,
                                    size: 50,
                                    color: IconColor,
                                  ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(Data.listKontak[i]['name'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),),
                                    Text(Data.listKontak[i]['phone'],style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal))
                                  ],
                                ),
                                Spacer(),

                                PopupMenuButton(onSelected: (value) async {
                                  if (value == 1) {
                                    Data.listFavorite.add(Data.listKontak[i]);
                                    await Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (_) => FavoritePage()));
                                  }
                                  if (value == 2){
                                    TextControl.name2Controller.text=Data.listKontak[i]['name'];
                                  TextControl.phoneController.text=Data.listKontak[i]['phone'];
                                  TextControl.email2Controller.text=Data.listKontak[i]['email'];
                                  TextControl.companyController.text=Data.listKontak[i]['company'];
                                  TextControl.jobController.text=Data.listKontak[i]['job'];
                                    await Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (_) => EditContact(Data.listKontak[i]['id'])));
                                    TextControl.name2Controller.text='';
                                    TextControl.phoneController.text='';
                                    TextControl.email2Controller.text='';
                                    TextControl.companyController.text='';
                                    TextControl.jobController.text='';
                                  }

                                  else if (value == 3){
                                    var dio= Dio ();
                                    dio.options.headers['authorization']='Bearer ${TextControl.token}';
                                    try{
                                      var options = dio.options;
                                      var response = await dio.delete(
                                          'https://phone-book-api.herokuapp.com/api/v1/contacts/${Data.listKontak[i]['id']}');}
                                    catch (e, stackTrace) {
                                      print('Error: $e');
                                      print('Stack Trace: $stackTrace');
                                    }
                                    refresh();
                                  }
                                  },
                                  icon: Icon(Icons.more_horiz_rounded, color: Colors.black,),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Row(
                                          children: [
                                            Icon(Icons.star, color: Colors.black,),
                                            SizedBox(width: 8,),
                                            Text("Add to Favorite"),
                                          ],
                                        ),
                                        value: 1,
                                      ),
                                      PopupMenuItem(
                                        child: Row(
                                          children: [
                                            Icon(Icons.edit, color: Colors.black),
                                            SizedBox(width: 8,),
                                            Text("Edit"),
                                          ],
                                        ),
                                        value: 2,
                                      ),
                                      PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete, color: Colors.black),
                                          SizedBox(width: 8,),
                                          Text("Delete"),
                                        ],
                                      ),
                                      value: 3,)
                                    ]
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                alignment: Alignment.center,
                height: 55,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.shade600,
                      offset: Offset(5, -3),
                    )
                  ],
                  color: Colors.grey,
                ),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          // Navigate back to first route when tapped.
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RecentContact(),
                            ),
                          );
                          setState() {
                            _iconColor = Colors.black;
                          }
                        },
                        icon: Icon(
                          Icons.access_time,
                          color: _iconColor,
                          size: 30,
                        )),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          // Navigate back to first route when tapped.
                          setState() {
                            _iconColor = Colors.black;
                          }
                        },
                        icon: Icon(
                          Icons.person,
                          color: _iconColor,
                          size: 30,
                        )),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          // Navigate back to first route when tapped.
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => FavoritePage(),
                            ),
                          );
                          setState() {
                            _iconColor = Colors.black;
                          }
                        },
                        icon: Icon(
                          Icons.star_border,
                          color: _iconColor,
                          size: 30,
                        )),
                  ],
                ),
              )
            ]));
  }
}
