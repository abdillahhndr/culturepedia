// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:culturalpedia/model/model_sejarah.dart';
import 'package:culturalpedia/screens/page_addsejarah.dart';
import 'package:culturalpedia/screens/page_editsejarah.dart';
import 'package:culturalpedia/screens/page_login.dart';
import 'package:culturalpedia/screens/page_profile.dart';
import 'package:culturalpedia/util/cek_session.dart';
import 'package:culturalpedia/util/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageListSejarah extends StatefulWidget {
  const PageListSejarah({super.key});

  @override
  State<PageListSejarah> createState() => _PageListSejarahState();
}

class _PageListSejarahState extends State<PageListSejarah> {
  TextEditingController txtcari = TextEditingController();
  bool isCari = false;
  bool isLoading = false;
  late List<Datum> _allSejarah = [];
  late List<Datum> _searchResult = [];

  @override
  void initState() {
    // TODO: implement initState
    getSejarah();
    super.initState();
  }

  Future<void> refreshData() async {
    await getSejarah(); // Panggil fungsi untuk mengambil data terbaru
    setState(() {}); // Memperbarui state untuk memicu pembangunan ulang widget
  }

  Future<List<Datum>?> getSejarah() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.get(Uri.parse('$url/listsejarah.php'));
      List<Datum> data = modelSejarahFromJson(res.body).data ?? [];
      setState(() {
        _allSejarah = data;
        _searchResult = data;
      });
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
        print(e.toString());
      });
    }
  }

  String baseUrl = '$url';
  Future<void> deleteData(String id) async {
    // Replace with your actual API endpoint
    final url = Uri.parse('$baseUrl/hapus.php');

    // Prepare the POST body with the ID
    final Map<String, String> data = {'id': id};

    try {
      final response = await http.post(url, body: data);

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        if (decodedResponse['status'] == 'success') {
          print('Data deleted successfully!');
        } else {
          print('Failed to delete data: ${decodedResponse['message']}');
        }
      } else {
        // Handle unsuccessful responses (e.g., network errors, server errors)
        print('Error deleting data: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions (e.g., network connection issues)
      print('Error deleting data: $error');
    }
  }

  void _filterBerita(String query) {
    List<Datum> filteredBerita = _allSejarah
        .where((sejarah) =>
            sejarah.nama!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _searchResult = filteredBerita;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              icon: Icon(
                Icons.person,
                color: Colors.white,
              )),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            'Historian Info',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
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
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, index) {
                        Datum data = _searchResult[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => detilsejarah(data)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            child: Card(
                              child: ListTile(
                                leading: Image.network(
                                  '$url/image/${data.foto}',
                                  height: 200,
                                ),
                                title: Text(
                                  "${data.nama}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "${data.tglLhr}",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PageEditsejarah(data),
                                            ));
                                        refreshData();
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 24,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        final idToDelete =
                                            '${data.id}'; // Replace with the ID to delete
                                        await deleteData(idToDelete);
                                        getSejarah();
                                      },
                                      icon: const Icon(
                                        Icons.delete_forever_outlined,
                                        size: 24,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
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
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PageAddsejarah()));
          },
          splashColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.transparent,
          mini: true,
          child: const Icon(
            Icons.add,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class detilsejarah extends StatelessWidget {
  final Datum? data;
  const detilsejarah(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historian Details'),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Color.fromARGB(255, 162, 190, 196),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    '$url/image/${data?.foto}',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  data?.nama ?? "",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                subtitle: Text('${data?.tglLhr}'),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(data?.asal ?? ""),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  data?.deskripsi ?? "",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
