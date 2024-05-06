import 'dart:convert';
import 'dart:io';
import 'package:culturalpedia/model/model_sejarah.dart';
import 'package:culturalpedia/screens/page_listsejarah.dart';
import 'package:culturalpedia/util/url.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageEditsejarah extends StatefulWidget {
  final Datum? data;

  const PageEditsejarah(this.data, {super.key});

  @override
  State<PageEditsejarah> createState() => _PageEditsejarahState();
}

class _PageEditsejarahState extends State<PageEditsejarah> {
  TextEditingController namaController = TextEditingController();
  TextEditingController tgl_lahir = TextEditingController();
  TextEditingController asal = TextEditingController();
  TextEditingController jenis_kelamin = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  File? _image;

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  Future<void> editDataSejarah(
    String id,
    String nama,
    String tanggalLahir,
    String asal,
    String jenisKelamin,
    String deskripsi,
    File? foto,
  ) async {
    try {
      // URL API edit data sejarah
      String apiUrl = '$url/edit.php';

      // Membuat permintaan multipart/form-data
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Menambahkan data ke dalam permintaan
      request.fields['id'] = id;
      request.fields['nama'] = nama;
      request.fields['tgl_lhr'] = tanggalLahir;
      request.fields['asal'] = asal;
      request.fields['jenis_kelamin'] = jenisKelamin;
      request.fields['deskripsi'] = deskripsi;

      // Jika foto tidak null, tambahkan file gambar ke dalam permintaan
      if (foto != null) {
        request.files.add(await http.MultipartFile.fromPath('foto', foto.path));
      }

      // Mengirim permintaan ke API
      var response = await request.send();

      // Membaca respons dari server
      if (response.statusCode == 200) {
        // Baca respons sebagai string
        String responseData = await response.stream.bytesToString();

        // Parsing respons JSON
        Map<String, dynamic> jsonResponse = json.decode(responseData);

        // Periksa apakah pengeditan berhasil atau tidak
        if (jsonResponse['isSuccess']) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PageListSejarah()));
          print('Data berhasil diupdate: ${jsonResponse['message']}');
        } else {
          print('Gagal mengupdate data: ${jsonResponse['message']}');
        }
      } else {
        // Jika respons tidak berhasil
        print('Gagal menghubungi server. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani kesalahan jika ada
      print('Error: $e');
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
                      labelText: "${widget.data?.nama}",
                      hintText: "${widget.data?.nama}",
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
                      labelText: "${widget.data?.tglLhr}",
                      hintText: "${widget.data?.tglLhr}",
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
                      labelText: "${widget.data?.asal}",
                      hintText: "${widget.data?.asal}",
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
                      labelText: "${widget.data?.jenisKelamin}",
                      hintText: "${widget.data?.jenisKelamin}",
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
                      labelText: "${widget.data?.deskripsi}",
                      hintText: "${widget.data?.deskripsi}",
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
                        editDataSejarah(
                          '${widget.data?.id}'.toString(),
                          namaController.text.toString(),
                          tgl_lahir.text.toString(),
                          asal.text.toString(),
                          jenis_kelamin.text.toString(),
                          deskripsi.text.toString(),
                          _image,
                        );
                        //                     String id,
                        // String nama,
                        // String tanggalLahir,
                        // String asal,
                        // String jenisKelamin,
                        // String deskripsi,
                        // File? foto,
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
