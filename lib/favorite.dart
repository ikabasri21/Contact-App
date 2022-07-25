import 'package:contact_app/newcontact.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'package:contact_app/recent.dart';
import 'mycontact.dart';
import 'package:contact_app/signin_class.dart';
import 'contactdetail.dart';

class FavoritePage extends StatelessWidget {
  TextEditingController? _textEditingController = TextEditingController();
  Color _iconColor = Colors.black;

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
                            "Favorite",
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                child: ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < Data.listFavorite.length; i++)
                          GestureDetector(
                            onTapUp: (value) async {
                              TextControl.nameController.text=Data.listKontak[i]['name'];
                              TextControl.phoneController.text=Data.listKontak[i]['phone'];
                              TextControl.emailController.text=Data.listKontak[i]['email'];
                              TextControl.companyController.text=Data.listKontak[i]['company'];
                              TextControl.jobController.text=Data.listKontak[i]['job'];
                              await Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (_) => ContactDetail(Data.listKontak[i]['id'])));

                              Data.listRecent.add(Data.listKontak[i]);
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
                                    Text(Data.listFavorite[i]['name']),
                                    Text(Data.listFavorite[i]['phone'])
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {/*
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                            return ContactDetail();
                                          }));*/
                                    },
                                    icon: Icon(Icons.star))
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
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.grey.shade600, offset: Offset(5, -3),)
                ], color: Colors.grey,),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          // Navigate back to first route when tapped.
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => RecentContact(),
                            ),
                          );
                          setState() {
                            _iconColor = Colors.black;
                          }
                        },
                        icon: Icon(Icons.access_time,
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
                              builder: (BuildContext context) => MyContact(),
                            ),
                          );
                          setState() {
                            _iconColor = Colors.black;
                          }
                        },
                        icon: Icon(Icons.person_outline,
                          color: _iconColor,
                          size: 30,
                        )),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          // Navigate back to first route when tapped.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => RecentContact(),
                            ),
                          );
                          setState() {
                            _iconColor = Colors.black;
                          }
                        },
                        icon: Icon(Icons.star,
                          color: _iconColor,
                          size: 30,
                        )),
                  ],
                ),
              )
            ]));
  }
}
