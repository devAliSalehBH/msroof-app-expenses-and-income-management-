import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:msroof/AuthController.dart';
import 'dart:io';

import 'Link.dart';
import 'main.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List ExpenItem = [];
  AuthController _authController = AuthController();
  Future deleteIncom(i) async {
    print(ExpenItem);
    var res = await _authController.DeleteIncom(DELETE, {
      "table": "2",
      "Id": ExpenItem[i]["ID"].toString(),
      "user_Id": user_id,
      "price": ExpenItem[i]["Price"]
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
    var url = READINCOM + '?user_id=$user_id&table=2';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);

      setState(() {
        if (red["result"] == "not here") {
          print("not here");
        } else {
          ExpenItem.addAll(red["result"]);
        }
      });
      print("tttttttttttttttttttt" + ExpenItem.toString());
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
        appBar: myAppBar("المصاريف", Icon(Icons.list_alt)),
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
                      Navigator.pushNamed(context, "addExpen");
                    },
                    child: Text(" اضافة مصروف جديد")),
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 480,
              child: ListView.builder(
                  itemCount: ExpenItem.length,
                  itemBuilder: (context, i) {
                    return Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 90,
                      child: Card(
                        child: Center(
                          child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 216, 98, 98),
                                  foregroundColor: Colors.white,
                                  radius: 20,
                                  child: Icon(Icons.attach_money)),
                              title: Text(ExpenItem[i]["Name"].toString()),
                              subtitle: Container(
                                  child: Row(
                                children: [
                                  Text(
                                    "-" +
                                        ExpenItem[i]["Price"].toString() +
                                        " ريال ",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 184, 46, 46)),
                                  ),
                                  SizedBox(width: 20),
                                  Text(ExpenItem[i]["Date"].toString()),
                                ],
                              )),
                              trailing: IconButton(
                                onPressed: () {
                                  print(ExpenItem[i]["ID"].toString());
                                  setState(() {
                                    totalExpen = (int.parse(totalExpen) -
                                            int.parse(ExpenItem[i]["Price"]))
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
                    "اجمالي المصاريف : $totalExpen",
                    style: TextStyle(color: Colors.white),
                  ))),
            ),
          ],
        ));
  }
}
