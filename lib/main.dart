import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

var request = Uri.https('api.hgbrasil.com','/finance',{'key':'bd59f4f5'});
void main()async{
  print(await pegarDados());
  runApp(
    MaterialApp(
      home: Home(),)
  );

}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{ 
String ibovespaNome='';
String ibovespaLocal ='';
String ibovespaPonto = '';
String ibovespaVariacao='';

String nasaNome='';
String nasaLocal ='';
String nasaPonto = '';
String nasaVariacao='';

String nikkeiNome='';
String nikkeiLocal ='';
String nikkeiVariacao='';

String cacNome='';
String cacLocal ='';
String cacVariacao='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Bolsa de valores'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: pegarDados(),
        builder: (context, snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                    "Carregando dados",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25,
                    ),
                  )
              );  
              default:
              if (snapshot.hasError){
                return Center(
                child: Text(
                    "Erro ao carregar",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                    ),
                  )
              );

              }else{
                final data = snapshot.data! as Map<String, dynamic>;
                //ibovespa
                ibovespaNome = data['results']['stocks']['IBOVESPA']['name'].toString();
                ibovespaLocal = data['results']['stocks']['IBOVESPA']['location'].toString();
                ibovespaPonto = data['results']['stocks']['IBOVESPA']['points'].toString();
                ibovespaVariacao = data['results']['stocks']['IBOVESPA']['variation'].toString();
                //nasdaq
                nasaNome = data['results']['stocks']['NASDAQ']['name'].toString();
                nasaLocal = data['results']['stocks']['NASDAQ']['location'].toString();
                nasaPonto = data['results']['stocks']['NASDAQ']['points'].toString();
                nasaVariacao = data['results']['stocks']['NASDAQ']['variation'].toString();
                //  nikkei
                nikkeiNome = data['results']['stocks']['NIKKEI']['name'].toString();
                nikkeiLocal = data['results']['stocks']['NIKKEI']['location'].toString();
                nikkeiVariacao = data['results']['stocks']['NIKKEI']['variation'].toString();
                //CAC
                cacNome = data['results']['stocks']['CAC']['name'].toString();
                cacLocal = data['results']['stocks']['CAC']['location'].toString();
                cacVariacao = data['results']['stocks']['CAC']['variation'].toString();

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset('images/bolsa.jpg',
                      fit: BoxFit.cover,
                      height: 100,),
                      Divider(),
                      Text(nasaNome,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 25,
                      ),),
                      Divider(),
                      Text(ibovespaNome,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 25,
                      ),),
                      Divider(),
                      Text(cacNome,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 25,
                      ),)
                      
                    ],

                  ),
                );
              }
              
          }
        },
      )
      
    );
  }
}

Future <Map> pegarDados()async{
  http.Response response = await http.get(request);
  return json.decode(response.body);
}