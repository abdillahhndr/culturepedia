// ignore_for_file: prefer_const_constructors

import 'package:culturalpedia/model/model_berita.dart';
import 'package:culturalpedia/util/url.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PageDetailBerita extends StatelessWidget {
  //konstruktor penampung data
  final Datum? data;
  const PageDetailBerita(this.data, {super.key});

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
        title: Text(data!.judul),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                '$url/image/${data?.gambar}',
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Text(
              data?.judul ?? "",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            subtitle:
                Text(DateFormat().format(data?.created ?? DateTime.now())),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              data?.konten ?? "",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
