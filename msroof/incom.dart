import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:msroof/AuthController.dart';
import 'dart:io';

import 'Link.dart';
import 'main.dart';

class Incom extends StatefulWidget {
  const Incom({Key? key}) : super(key: key);
  @override
  State<Incom> createState() => _IncomState();
}

class _IncomState extends State<Incom> {
  List incomItem = [];
  AuthController _authController = AuthController();
  Future deleteIncom(i) async {
    print(incomItem);
    var res = await _authController.DeleteIncom(DELETE, {
      "table": "1",
      "Id": incomItem[i]["ID"].toString(),
      "user_Id": user_id,
      "price": incomItem[i]["Price"]
    });
    if (res["result"] == "done") {
      print("done");
    } else {
      print("suiiiiiiii");
      print(res["result"].toString());
    }
    setState(() {});
  }

  Future ReadData() async {
    var url = READINCOM + '?user_id=$user_id&table=1';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);

      setState(() {
        if (red["result"] == "not here") {
          print("not here");
        } else {
          incomItem.addAll(red["result"]);
        }
      });
      print("tttttttttttttttttttt" + incomItem.toString());
    }
  }

  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    await ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar("الدخل", Icon(Icons.attach_money)),
        backgroundColor: Color.fromARGB(255, 241, 241, 241),
        body: Column(
          children: [
            SizedBox(height: 30),
            Center(
              child: Container(
                width: 330,
                height: 45,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "addIncom");
                    },
                    child: Text(" اضافة دخل جديد")),
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 480,
              child: ListView.builder(
                  itemCount: incomItem.length,
                  itemBuilder: (context, i) {
                    return Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 90,
                      child: Card(
                        child: Center(
                          child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 98, 216, 104),
                                  foregroundColor: Colors.white,
                                  radius: 20,
                                  child: Icon(Icons.attach_money)),
                              title: Text(incomItem[i]["Name"].toString()),
                              subtitle: Container(
                                  child: Row(
                                children: [
                                  Text(
                                    "+" +
                                        incomItem[i]["Price"].toString() +
                                        " ريال ",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 46, 184, 76)),
                                  ),
                                  SizedBox(width: 20),
                                  Text(incomItem[i]["Date"].toString()),
                                ],
                              )),
                              trailing: IconButton(
                                onPressed: () {
                                  print(incomItem[i]["ID"].toString());
                                  setState(() {
                                    totalincom = (int.parse(totalincom) -
                                            int.parse(incomItem[i]["Price"]))
                                        .toString();

                                    deleteIncom(i);
                                    // http.delete(Uri.parse(LOGIN), body: {
                                    // 'ID': incomItem[i]["ID"].toString()
                                    //});
                                  });
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 30),
            Center(
              child: Container(
                  width: 330,
                  height: 45,
                  color: Colors.black,
                  child: Center(
                      child: Text(
                    "اجمالي الدخل : $totalincom",
                    style: TextStyle(color: Colors.white),
                  ))),
            ),
          ],
        ));
  }
}
