// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});
  
  get leading => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Center(
            child: Text(
              "الملف الشخصي ",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          centerTitle: true,
          // leading: Icon(
          //   Icons.message,
          //   size: 26,
          //   color: Colors.white,
          // ),
          // actions: [
          //   IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.search,
          //         color: Colors.white,
          //         size: 26,
          //       )),

          //   IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.search,
          //         color: Colors.white,
          //         size: 26,
          //       ))
          // ],
        ),
        body:Padding(
        padding: const EdgeInsets.all(7),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/IMG_6645.PNG'),
            ),
            const SizedBox(height: 20),
            itemProfile('Name', 'FAY ALmtuairi', CupertinoIcons.person),
            const SizedBox(height: 10),
            itemProfile('Phone', '053046609', CupertinoIcons.phone),
            const SizedBox(height: 10),
            itemProfile('Address', 'Saudi Arabia, Qassim', CupertinoIcons.location),
            const SizedBox(height: 10),
            itemProfile('Email', 'fayalmtuairi@gmail.com', CupertinoIcons.mail),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
             
            )
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.pink[100],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            // BoxShadow(
            //     offset: Offset(0, 5),
            //     color: Colors.deepOrange.withOpacity(.2),
            //     spreadRadius: 2,
            //     blurRadius: 10
            // )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
  
}
