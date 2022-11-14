import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AboutPage extends StatefulWidget {
  static const routeName = "/about";
  final String link, about;

  const AboutPage({Key? key, required this.link, required this.about}) : super(key: key);
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.link.replaceAll("-", ""))),
    body: SingleChildScrollView(child: Text(widget.about)),
    );
  }
}