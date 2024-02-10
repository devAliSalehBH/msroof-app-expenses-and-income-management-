import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:msroof/AuthController.dart';
import 'package:msroof/Link.dart';
import 'package:msroof/validate.dart';
import 'package:intl/date_symbol_data_custom.dart';
import 'main.dart';
import 'Home.dart';

class AddExpen extends StatefulWidget {
  const AddExpen({Key? key}) : super(key: key);
  @override
  State<AddExpen> createState() => _AddExpenState();
}

class _AddExpenState extends State<AddExpen> {
  DateTime Date = DateTime.now();
  Home h = Home();
  TextEditingController price = TextEditingController();
  TextEditingController _Date2 = TextEditingController();
  List<String> incomType = [
    'شخصي',
    'الغذاء',
    'الاسرة',
    'المواصلات',
    'الملابس',
    'اخرى'
  ];
  String? selectedItem = 'شخصي';
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  AuthController _authController = AuthController();
  bool loading = false;
  add_Incom() async {
    var data = await _authController.LoginAuth(ADDINCOM, {
      "price": price.text,
      "name": selectedItem.toString(),
      "u_id": user_id,
      "table_id": '2',
      "date": _Date2.text,
    });

    if (data["result"] == "done") {
      setState(() {
        currentIndex = 1;
      });
      print("done");
      totalExpen = (int.parse(totalExpen) + int.parse(price.text)).toString();
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    } else {
      print("huuuuuuuuu");
      print(data["result"].toString());
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("اضافة مصروف ", Icon(Icons.switch_account)),
      body: Column(
        key: formstate,
        children: [
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              validator: (val) {
                return validInput(val!, 40, 4, false);
              },
              controller: _Date2,
              obscureText: false,
              readOnly: true,
              onTap: () async {
                DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
                if (newDate != null) {
                  setState(() {
                    _Date2.text = DateFormat('yyyy-MM-dd').format(newDate);
                  });
                }
              },
              decoration: InputDecoration(
                labelText: "التاريخ : ",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            height: 70,
            width: 322,
            child: DropdownButtonFormField<String>(
              validator: (val) {
                return validInput(val!, 100, 1, false);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: ('الفئة'),
              ),
              value: selectedItem,
              items: incomType
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ))
                  .toList(),
              onChanged: (item) => setState(() => selectedItem = item),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              validator: (val) {
                return validInput(val!, 40, 4, false);
              },
              keyboardType: TextInputType.number,
              controller: price,
              obscureText: false,
              decoration: InputDecoration(
                labelText: "المبلغ",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 30),
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
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      print(_Date2.text +
                          "  " +
                          price.text +
                          "  " +
                          selectedItem.toString());
                      add_Incom();
                    },
                    child: Text("اضافة"))),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: () {
                  selectedItem = 'الراتب';
                  price.text = "";
                  _Date2.text = "";
                },
                child: Icon(Icons.refresh),
              ),
            )
          ],
        ),
      ),
    );
  }
}
