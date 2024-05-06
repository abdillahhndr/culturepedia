import 'package:culturalpedia/model/model_berita.dart';
import 'package:culturalpedia/screens/page_login.dart';
import 'package:culturalpedia/screens/page_profile.dart';
import 'package:culturalpedia/util/cek_session.dart';
import 'package:culturalpedia/util/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Galery extends StatefulWidget {
  const Galery({super.key});

  @override
  State<Galery> createState() => _GaleryState();
}

class _GaleryState extends State<Galery> {
  String? id, username;
  bool isLoading = false;
  TextEditingController txtcari = TextEditingController();

  Future<List<Datum>?> getBerita() async {
    try {
      http.Response res = await http.get(Uri.parse('$url/berita.php'));
      return modelBeritaFromJson(res.body).data;
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getBerita();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CulturalPedia'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffE16B7B),
                Color(0xff64A0FB),
                Color(0xff79D7B1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageProfile()),
                );
              },
              icon: Icon(Icons.person)),
          IconButton(
              onPressed: () {
                //sesi logout
                setState(() {
                  session.clearSession();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => PageLogin()),
                      (route) => false);
                });
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Gallery Photos',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: getBerita(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Datum>?> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          Datum? data = snapshot.data?[index];
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {},
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          '$url/image/${data?.gambar}',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
