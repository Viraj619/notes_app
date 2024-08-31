


import 'package:flutter/material.dart';
import 'package:notes/database/local/dbhepler_page.dart';
import 'package:notes/provider_page.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

void main(){
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ProviderPage(dbHepler:DbheplerPage.getInstance()),)
  ],child: MainApp()));
}
class MainApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}