import 'package:flutter/material.dart';

class Homeprincipal extends
StatefulWidget{
  const Homeprincipal({super.key});

  @override
  State<Homeprincipal> createState() =>
  _HomePrincipalState();
} 

class _HomePrincipalState extends
State<Homeprincipal>{
@override
 Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Center(
        child: const Text("Datos Personales",
    style: TextStyle (fontWeight: FontWeight.bold, color: Colors.white),
       ),
       ),
       backgroundColor: Colors.amber,
       ),
       body: Center(
        
        child: Card(
          child: Column(
            children: [
              Row(children: [Text("Nombre", style: TextStyle(color: Colors.blue))]),
              Row(children: [Text("Apellido")]),

            ],
          ) 
        )
       ),
  );
 }
}





