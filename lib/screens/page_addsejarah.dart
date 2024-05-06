import 'dart:io';
import 'package:culturalpedia/screens/page_listsejarah.dart';
import 'package:culturalpedia/util/url.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageAddsejarah extends StatefulWidget {
  const PageAddsejarah({super.key});

  @override
  State<PageAddsejarah> createState() => _PageAddsejarahState();
}

class _PageAddsejarahState extends State<PageAddsejarah> {
  TextEditingController namaController = TextEditingController();
  TextEditingController tgl_lahir = TextEditingController();
  TextEditingController asal = TextEditingController();
  TextEditingController jenis_kelamin = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  File? _image;
  String url1 = '$url';

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  Future<void> _uploadData() async {
    String url = '$url1/addsejarah.php';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['nama'] = namaController.text;
    request.files.add(await http.MultipartFile.fromPath('foto', _image!.path));
    request.fields['tgl_lhr'] = tgl_lahir.text;
    request.fields['asal'] = asal.text;
    request.fields['jenis_kelamin'] = jenis_kelamin.text;
    request.fields['deskripsi'] = deskripsi.text;

    var response = await request.send();

    if (response.statusCode == 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PageListSejarah()));
      print('Data berhasil disimpan.');
    } else {
      print('Gagal menyimpan data. Status code: ${response.statusCode}');
    }
  }

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Historian'),
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
      body: SingleChildScrollView(
        child: Form(
          key: keyForm,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                _image == null
                    ? ElevatedButton(
                        onPressed: _getImage,
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(16.0),
                          backgroundColor: Colors.grey,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 32.0,
                          color: Colors.white,
                        ),
                      )
                    : Image.file(_image!),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: namaController,
                  validator: (val) {
                    return val!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Name",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.blue.shade300),
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: tgl_lahir,
                  validator: (val) {
                    return val!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                      labelText: "Date Of Birth",
                      hintText: "Date Of Birth",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: asal,
                  validator: (val) {
                    return val!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                      labelText: "Nationality",
                      hintText: "Nationality",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: jenis_kelamin,
                  validator: (val) {
                    return val!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                      labelText: "Gender",
                      hintText: "Gender",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: deskripsi,
                  validator: (val) {
                    return val!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 14,
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
                      if (keyForm.currentState?.validate() == true) {
                        _uploadData();
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("silahkan isi data terlebih dahulu"),
                        ));
                      }
                    }, // Remove splash effect
                    child: Text("Submit"),
                    textColor: Colors.white,
                    height: 45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
