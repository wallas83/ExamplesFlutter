import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_api/src/pages/home_page.dart';
import 'package:scroll_api/src/services/pelicula_service.dart';

void main() {
  runApp(MyApp());
}

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PeliculaService(),),
          
        ],
              child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Scroll',
          initialRoute: '/',
          routes: {
            '/'     : (BuildContext context) => HomePage()
          },
        ),
      );
    }
  }