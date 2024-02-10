import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:msroof/AuthController.dart';
import 'package:msroof/Link.dart';

import 'main.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  AuthController _authController = AuthController();
  Future deleteAccount() async {
    var res = await _authController.DeleteIncom(DELETEACCOUNT, {
      "user_Id": user_id,
    });
    if (res["result"] == "done") {
      print("ddsdsd");
      Navigator.pushNamedAndRemoveUntil(context, "logIn", (route) => false);
    } else {
      print("ali");
      print(res["result"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("الحساب", Icon(Icons.switch_account)),
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Text("تعديل معلومات الحساب", style: TextStyle(fontSize: 17)),
          SizedBox(height: 20),
          infoFiald(false, "الاسم", name, false),
          SizedBox(height: 30),
          infoFiald(false, "كلمة المرور", pass, false),
          SizedBox(height: 30),
          Center(
            child: Container(
              width: 330,
              height: 45,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "addExpen");
                  },
                  child: Text("تعديل معلومات الحساب")),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 20, right: 30),
        child: Row(
          children: [
            Container(
                width: 240,
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 226, 48, 48)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(""),
                              content: Text("هل انت متاكد من حذف الحساب"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      deleteAccount();
                                    },
                                    child: Text("تاكيد")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("الغاء")),
                              ],
                            );
                          });
                    },
                    child: Text("حذف الحساب"))),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 0, 0, 0)),
                onPressed: () {
                  currentIndex = 0;
                  Navigator.pushNamedAndRemoveUntil(
                      context, "logIn", (route) => false);
                  ;
                },
                child: Icon(Icons.logout_outlined),
              ),
            )
          ],
        ),
      ),
    );
  }
}
