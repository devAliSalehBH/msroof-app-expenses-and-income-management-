import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msroof/AddExpen.dart';
import 'package:msroof/AddIncom.dart';
import 'package:msroof/LogIn.dart';
import 'package:msroof/validate.dart';
import 'SignUp.dart';
import 'Home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

String user_id = '';

String totalincom = '';
String totalExpen = '';
int currentIndex = 0;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "AE"),
      ],
      locale: Locale("ar", "AE"),
      theme: ThemeData(
        fontFamily: 'Almarai',
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "logIn",
      routes: {
        '/': (context) => Home(),
        'signUp': (context) => SignUp(),
        'logIn': (context) => LogIn(),
        'addIncom': (context) => AddIncom(),
        'addExpen': (context) => AddExpen(),
      },
    );
  }
}

Widget infoFiald(isObscure, lbText, cont, isemail) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: TextFormField(
      validator: (val) {
        return validInput(val!, 40, 4, isemail);
      },
      controller: cont,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: lbText,
        border: OutlineInputBorder(),
      ),
    ),
  );
}

myAppBar(title, icon) {
  return AppBar(
    backgroundColor: Colors.green,
    foregroundColor: Color.fromARGB(255, 240, 240, 240),
    leading: icon,
    title: Text(title),
  );
}
