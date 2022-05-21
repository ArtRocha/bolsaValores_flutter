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
      body: FutureBuilder<Map>(
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
                //ibovespa
                ibovespaNome =  snapshot.data!['results']['stocks']['IBOVESPA']['name'].toString();
                ibovespaLocal =  snapshot.data!['results']['stocks']['IBOVESPA']['location'].toString();
                ibovespaPonto =  snapshot.data!['results']['stocks']['IBOVESPA']['points'].toString();
                ibovespaVariacao =  snapshot.data!['results']['stocks']['IBOVESPA']['variation'].toString();
                //nasdaq
                nasaNome =  snapshot.data!['results']['stocks']['NASDAQ']['name'].toString();
                nasaLocal =  snapshot.data!['results']['stocks']['NASDAQ']['location'].toString();
                nasaPonto =  snapshot.data!['results']['stocks']['NASDAQ']['points'].toString();
                nasaVariacao =  snapshot.data!['results']['stocks']['NASDAQ']['variation'].toString();
                //nikkei
                nikkeiNome =  snapshot.data!['results']['stocks']['NIKKEI']['name'].toString();
                nikkeiLocal =  snapshot.data!['results']['stocks']['NIKKEI']['location'].toString();
                nikkeiVariacao =  snapshot.data!['results']['stocks']['NIKKEI']['variation'].toString();
                //CAC
                cacNome =  snapshot.data!['results']['stocks']['CAC']['name'].toString();
                cacLocal =  snapshot.data!['results']['stocks']['CAC']['location'].toString();
                cacVariacao =  snapshot.data!['results']['stocks']['CAC']['variation'].toString();

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset('images/borsa.jpg',
                      fit: BoxFit.cover,
                      height: 200,),
                      Divider(),
                      Text(nasaNome,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 25,
                      ),),
                      Text(nasaLocal,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 25,
                      ),),
                      Text(nasaPonto,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 25,
                      ),),
                      Text(nasaVariacao,
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
                      Text(ibovespaLocal,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 25,
                      ),),
                      Text(ibovespaPonto,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 25,
                      ),),
                      Text(ibovespaVariacao,
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
                      ),),
                      Text(cacLocal,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 25,
                      ),),
                      Text(cacVariacao,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 25,
                      ),),
                      
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