import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import "package:flutter/services.dart";

class ArtistPage extends StatefulWidget {
  static const routeName = "/artist";
  ArtistPage({super.key});

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage>  {

  Future<List>getDataFromJson() async{
    List artists = [];
    final String response = await rootBundle.loadString('assets/artists.json');
    artists = await json.decode(response);
    return artists;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getDataFromJson(),
    builder: (BuildContext context, AsyncSnapshot<List> snapshot)=>snapshot.hasData
    ? Scaffold(body: ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (BuildContext context, index) => Card(
        child: ListTile(
          title: Text(snapshot.data![index]['name']),
             onTap: () {
               Navigator.pushNamed(context, "/about", arguments: {
                'link': snapshot.data![index]['link'],
                'about': snapshot.data![index]['about']
            });
          },
        ),
      ),
    ), appBar: AppBar(),
    ): const Center(child: Text("Ups"),)); //Подсмотрел такой приём в интернете, думаю <?> и <:> можно использовать в этом случае
  }
  
  @override
  bool get wantKeepAlive => true;
}