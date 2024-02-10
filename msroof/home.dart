import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'Incom.dart';
import 'Expenses.dart';
import 'Account.dart';
import 'main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final pages = [HomePage(), Expenses(), Incom(), Account()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: GNav(
            selectedIndex: currentIndex,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            color: const Color.fromARGB(255, 0, 0, 0),
            activeColor: Colors.green,
            tabBackgroundColor: Color.fromARGB(255, 223, 222, 222),
            gap: 8,
            padding: EdgeInsets.all(8),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "الرئيسية",
              ),
              GButton(
                icon: Icons.list_alt,
                text: "المصاريف",
              ),
              GButton(
                icon: Icons.attach_money,
                text: "الدخل",
              ),
              GButton(
                icon: Icons.switch_account,
                text: "الحساب",
              )
            ],
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("الرئيسية", Icon(Icons.home)),
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 27),
                Center(
                  child: Container(
                      width: 152,
                      height: 55,
                      color: Colors.redAccent,
                      child: Center(
                          child: Text(
                        "المصاريف  : " + (int.parse(totalExpen)).toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ))),
                ),
                SizedBox(width: 25),
                Center(
                  child: Container(
                      width: 152,
                      height: 55,
                      color: const Color.fromARGB(255, 83, 182, 87),
                      child: Center(
                          child: Text(
                        "الدخل  : " + (int.parse(totalincom)).toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ))),
                )
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                  width: 330,
                  height: 55,
                  color: Color.fromARGB(255, 112, 112, 112),
                  child: Center(
                      child: Text(
                    "الرصيد الحالي  : " +
                        (int.parse(totalincom) - int.parse(totalExpen))
                            .toString(),
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ))),
            ),
            SizedBox(height: 30),
            Container(
              height: 300,
              width: 350,
              child: SfCartesianChart(),
            ),
            SizedBox(height: 600),
          ],
        ),
      ),
    );
  }
}
