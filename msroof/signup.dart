import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:msroof/AuthController.dart';
import 'package:msroof/Link.dart';
import 'package:msroof/main.dart';
import 'LogIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  AuthController _authController = AuthController();
  bool loading = false;

  signup() async {
    var formData = formState.currentState;

    if (formData!.validate()) {
      setState(() {
        loading = true;
      });
      var data = await _authController.SignUpAuth(SIGNUP,
          {"name": username.text, "email": email.text, "pass": pass.text});

      if (data["result"] == "done") {
        Navigator.pushNamedAndRemoveUntil(context, "logIn", (route) => false);
      } else {
        await Future.delayed(Duration(seconds: 1));
        setState(() {
          loading = false;
        });
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text("هذا الايميل موجود مسبقاً"),
                ));
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formState,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'انشاء حساب',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              infoFiald(false, "الاسم", username, false),
              SizedBox(height: 20),
              infoFiald(false, "الايميل", email, true),
              SizedBox(height: 20),
              infoFiald(true, "كلمة المرور", pass, false),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    signup();
                  },
                  child: loading == false
                      ? Text('انشاء الحساب')
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
                      context, "logIn", (route) => false);
                  ;
                },
                child: Text('لديك حساب ؟ سجل الدخول'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
