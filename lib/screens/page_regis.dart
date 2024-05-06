// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:culturalpedia/model/model_regis.dart';
import 'package:culturalpedia/screens/page_login.dart';
import 'package:culturalpedia/util/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageRegis extends StatefulWidget {
  const PageRegis({super.key});

  @override
  State<PageRegis> createState() => _PageRegisState();
}

class _PageRegisState extends State<PageRegis> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool _isObscure = true;
  bool isLoading = false;

  Future<ModelRegister?> registerAccount() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response res =
          await http.post(Uri.parse('$url/register.php'), body: {
        "username": txtUsername.text,
        "email": txtEmail.text,
        "password": txtPassword.text,
      });
      ModelRegister data = modelRegisterFromJson(res.body);
      //cek kondisi (ini berdasarkan value respon api
      //value 2 (email sudah terdaftar),1 (berhasil),dan 0 (gagal)
      if (data.value == 1) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
          //pindah ke page login
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const PageLogin()),
              (route) => false);
        });
      } else if (data.value == 2) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });
      }
    } catch (e) {
      //munculkan error
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F9FF),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(34),
          child: Form(
            key: keyForm,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 45,
                  decoration: BoxDecoration(
                      color: Color(0xffF2F2F2),
                      borderRadius: BorderRadius.circular(50)),
                  alignment: Alignment.topLeft,
                  child: Center(),
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Image.asset(
                        'assets/image/logo.png',
                        height: 170,
                      ),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: txtUsername,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: 'Username',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            size: 24,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: txtEmail,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: 'Email',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            size: 24,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: txtPassword,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            size: 24,
                          ),
                          suffixIcon: IconButton(
                            icon: _isObscure
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xffE16B7B),
                              Color(0xff64A0FB),
                              Color(0xff79D7B1),
                            ], // Customize your gradient colors
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (keyForm.currentState?.validate() == true) {
                              //kita panggil function register
                              registerAccount();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            elevation: 0.0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.center, // Tetap tengah
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Color(0xffF2F2F2),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors
                                      .white, // Warna latar belakang putih
                                  shape: BoxShape.circle, // Bentuk bulat
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black, // Warna ikon hitam
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Already have an Account?  ",
                            style: TextStyle(color: Colors.grey),
                            children: [
                              TextSpan(
                                  text: "Sign In",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PageLogin()));
                                    },
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ))
                            ]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
