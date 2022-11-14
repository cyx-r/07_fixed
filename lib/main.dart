// ignore_for_file: prefer_function_declarations_over_variables, prefer_const_constructors

import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'fetch_file.dart';
import 'ArtistPage.dart';
import "AboutPage.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch(settings.name){
          case '/':
            return MaterialPageRoute(builder: (BuildContext context){return HomePage();});
          case ArtistPage.routeName:
            return MaterialPageRoute(builder: (BuildContext context){return ArtistPage();});
          case AboutPage.routeName:
            return MaterialPageRoute(builder: (BuildContext context){
              final argument = settings.arguments as Map<String, dynamic>;
              if (argument.containsKey('link') && argument.containsKey('about')) {
                return AboutPage(
                  link: argument['link'],
                  about: argument['about'],
                );
              } else {
                return const AboutPage(
                  link: '',
                  about: '',
                );}//Я тут нагородил кучу- это чтобы не возиться с fetchFileFromAssets, у меня она не работает)
            });
          default: return MaterialPageRoute(builder: (BuildContext context){return HomePage();});
        }
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}


class DrawerElemet{ //На этом этапе я решил сделать отдельный элемент для Drawer'a
  String title;
  IconData icon;

  DrawerElemet(this.title,this.icon);
}


class HomePage extends StatefulWidget {
  HomePage({super.key});

  final drawerData = [DrawerElemet('Home Page', Icons.home), DrawerElemet("Artists Page", Icons.album)];


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedDrawerElement =0;

  _getSecelctedDrawerItem(int a){
        switch (a) {
        case 0:
          return HomePage();
        case 1:
          return ArtistPage();
        default:
          return const Text("Error");
      }
  }//Тут определяем, куда мы вообще нажали, вот такая логика

  _onSelectItem(int index) {
    setState(() => _selectedDrawerElement = index);
    _getSecelctedDrawerItem(_selectedDrawerElement);
    // Navigator.of(context).pop();
  }//Это тоже помогает ориентироваться

  @override
  Widget build(BuildContext context) {

    List<Widget> drawerWidgetList =[];

    for(int i =0; i< widget.drawerData.length; i++){
      drawerWidgetList.add(ListTile(title: Text(widget.drawerData[i].title), leading: Icon(widget.drawerData[i].icon),
      onTap: (() => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return ArtistPage();}))
      /*_onSelectItem(i)*/),
      selected: i == _selectedDrawerElement,
       ));
    }
    return Scaffold(
      appBar: AppBar(title:Text(widget.drawerData[_selectedDrawerElement].title)),
      body: Center(child: Text(widget.drawerData[_selectedDrawerElement].title)), //Благодаря конструкциям можно вот так задавать body 
      drawer: Drawer(child: Column(children: drawerWidgetList),
      ),
    );
  }
}
