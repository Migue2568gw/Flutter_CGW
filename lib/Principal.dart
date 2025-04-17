import 'package:flutter/material.dart';
import 'package:proyect/HomePrincipal.dart';

class Principal extends StatelessWidget {
  const Principal ({super.key});

  @override
  Widget build (BuildContext context){
    return MaterialApp( 
      title: "Politecnico: Primera Clase",
      debugShowCheckedModeBanner: false,
      home: Homeprincipal(),
    );
  }
}