// ignore_for_file: prefer_const_constructors

import 'package:culturalpedia/model/model_berita.dart';
import 'package:culturalpedia/screens/page_detailberita.dart';
import 'package:culturalpedia/screens/page_login.dart';
import 'package:culturalpedia/screens/page_profile.dart';
import 'package:culturalpedia/util/cek_session.dart';
import 'package:culturalpedia/util/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PageListBerita extends StatefulWidget {
  const PageListBerita({super.key});

  @override
  State<PageListBerita> createState() => _PageListBeritaState();
}

class _PageListBeritaState extends State<PageListBerita> {
  String? id, username;
  bool isLoading = false;
  TextEditingController txtcari = TextEditingController();

  late List<Datum> _allBerita = [];
  late List<Datum> _searchResult = [];

  @override
  void initState() {
    // TODO: implement initState
    getBerita();
    super.initState();
    getSession();
  }

  //  id = session.getSesiIdUser();
  //fungsion untuk get data berita
  Future<List<Datum>?> getBerita() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.get(Uri.parse('$url/berita.php'));
      List<Datum> data = modelBeritaFromJson(res.body).data ?? [];
      setState(() {
        _allBerita = data;
        _searchResult = data;
      });
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      username = pref.getString("username") ?? '';
      print('id $id');
    });
  }

  void _filterBerita(String query) {
    List<Datum> filteredBerita = _allBerita
        .where((berita) =>
            berita.judul!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _searchResult = filteredBerita;
    });
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
            child: Image.asset("assets/image/beritabanner.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: _filterBerita,
              controller: txtcari,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(Icons.search),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.blue.shade100,
                hintText: "Search",
                hintStyle: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, index) {
                Datum? data = _searchResult[index];
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      //ketika item di klik pindah ke detail
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PageDetailBerita(data)));
                    },
                    child: Card(
                      color: Color.fromARGB(255, 217, 235, 245),
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
                          ListTile(
                            title: Text(
                              '${data?.judul}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '${data?.created},   ${data?.konten}',
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
