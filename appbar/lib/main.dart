import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          /*leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            print('clicked');
          },
        ),*/
          title: Text('appbar demo'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            )
          ],
          flexibleSpace: SafeArea(
            child: Icon(
              Icons.camera,
            ),
          ),
          backgroundColor: Colors.green,
        ),
        body: Center(
            child: Text('welcome',
                style: TextStyle(fontSize: 28.0, color: Colors.blue))),
        drawer: Drawer(
            elevation: 10.0,
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: null,
                  accountEmail: null,
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                )
              ],
            )));
  }
}
