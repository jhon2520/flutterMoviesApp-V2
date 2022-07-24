import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app2/providers/movies_provider.dart';
import 'package:movies_app2/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_)=> MoviesProvider(), lazy: false,)
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //bloquear orientación de la app a un listado de orientaciones que defino
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: "home",
      routes: {
        "home":(_)=> HomeScreen(),
        "details":(_)=> DetailsScreen(),
      },
    theme: ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: Colors.teal
      )
    ),
    );
    
  }
}