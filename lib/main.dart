import 'package:flutter/material.dart';
import 'models/playlist_provider.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'themes/themeprovide.dart';

void main() {
  runApp(
    MultiProvider(providers:[
      ChangeNotifierProvider(create:(context)=>ThemeProvider()),
      ChangeNotifierProvider(create:(context)=>PlaylistProvider()),
    ],
    child:const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
