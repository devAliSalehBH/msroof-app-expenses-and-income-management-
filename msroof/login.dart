import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:msroof/AuthController.dart';
import 'package:msroof/Home.dart';
import 'package:msroof/Link.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  AuthController _authController = AuthController();

  bool loading = false;

  login() async {
    var formData = formstate.currentState;

    if (formData!.validate()) {
      setState(() {
        loading = true;
      });
      var data = await _authController.LoginAuth(
          LOGIN, {"email": email.text, "pass": pass.text});

      if (data["abc"] == "not here") {
        print(data["abc"]);
        await Future.delayed(Duration(seconds: 1));
        setState(() {
          loading = false;
        });

        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text("هذا الايميل غير موجود"),
                ));
      } else {
        //Navigator.of(context).pushNamed("/");

        SharedPreferences sph = await SharedPreferences.getInstance();
        user_id = data["abc"]["ID"];
        totalincom = data["abc"]["totalIncom"];
        totalExpen = data["abc"]["totalExpen"];
        print("ddddddddddddddddddddd" + user_id + totalincom);
        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formstate,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'تسجيل الدخول',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              infoFiald(false, "الايميل", email, false),
              SizedBox(height: 20),
              infoFiald(true, "كلمة المرور", pass, false),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: loading == false
                      ? Text('تسجيل الدخول')
                      : SizedBox(
                          width: 90,
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text("تحميل")
                            ],
                          ),
                        )),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "signUp", (route) => false);
                  // Navigate to the signuppage
                },
                child: Text('ليس لديك حساب ؟ قم بإنشاء حساب'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
