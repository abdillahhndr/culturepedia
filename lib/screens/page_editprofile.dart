import 'package:culturalpedia/model/model_edituser.dart';
import 'package:culturalpedia/screens/page_profile.dart';
import 'package:culturalpedia/util/cek_session.dart';
import 'package:culturalpedia/util/url.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PageEditProfile extends StatefulWidget {
  const PageEditProfile({super.key});

  @override
  State<PageEditProfile> createState() => _PageEditProfileState();
}

class _PageEditProfileState extends State<PageEditProfile> {
  TextEditingController txtusername = TextEditingController();
  TextEditingController txtemail = TextEditingController();

  String? id, username, email;
  bool isLoading = false;
  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      username = pref.getString("username") ?? '';
      email = pref.getString("email") ?? '';
      // print(id);
    });
  }

  Future<ModelEditUser?> updateAccount() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res =
          await http.post(Uri.parse('$url/updateUser.php'), body: {
        "id": '$id',
        "username": txtusername.text,
        "email": txtemail.text,
      });
      ModelEditUser data = modelEditUserFromJson(res.body);
      if (data.value == 1) {
        setState(() {
          isLoading = false;
          session.saveSession(data.value ?? 0, data.id ?? "",
              data.username ?? "", data.email ?? "");
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PageProfile()));
      } else if (data.value == 2) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(
        title: Text('Profile'),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffFFA0A0),
                Color(0xff98BEFF),
                Color(0xffAFF8BA),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 350,
            child: Expanded(
              // Wrap Image.asset with Expanded
              child: Image.asset(
                'assets/image/profile.png',
                fit: BoxFit.cover, // Cover the entire area
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: txtusername,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: '$username',
                  hintText: '$username',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: txtemail,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: '$email',
                  hintText: '$email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
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
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                updateAccount();
              }, // Remove splash effect
              child: Text("Done"),
              textColor: Colors.white,
              height: 45,
            ),
          ),
        ],
      ),
    );
  }
}
