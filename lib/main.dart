import 'package:culturalpedia/screens/page_addsejarah.dart';
import 'package:culturalpedia/screens/page_galery.dart';
import 'package:culturalpedia/screens/page_listberita.dart';
import 'package:culturalpedia/screens/page_listsejarah.dart';
import 'package:culturalpedia/screens/page_regis.dart';
import 'package:culturalpedia/screens/page_splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: const [
          PageListBerita(),
          Galery(),
          PageListSejarah(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                tabController.animateTo(0); // Home
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                tabController.animateTo(1); // Gallery
              },
              icon: const Icon(Icons.browse_gallery),
            ),
            IconButton(
              onPressed: () {
                tabController.animateTo(2); // Employee
              },
              icon: const Icon(Icons.book),
            ),
          ],
        ),
      ),
    );
  }
}
