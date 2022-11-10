import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late String _cotacaoCompraUsd;
  late String _cotacaoCompraBrl;

  Future<Map> _recuperarPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: _recuperarPreco(),
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none :
              _cotacaoCompraUsd = "Tente novamente";
              _cotacaoCompraBrl = "Tente novamente";
            break;
          case ConnectionState.waiting :
              _cotacaoCompraUsd = "Carregando...";
              _cotacaoCompraBrl = "Carregando...";
            break;
          case ConnectionState.active :
          case ConnectionState.done :
            if(snapshot.hasError){
              _cotacaoCompraUsd = "Erro ao carregar dados";
              _cotacaoCompraBrl = "Erro ao carregar dados";
            }else {
                _cotacaoCompraUsd = snapshot.data!["USD"]["buy"].toString();
                _cotacaoCompraBrl = snapshot.data!["BRL"]["buy"].toString();
            }
            break;
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.all(32),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/bitcoin.png"),
                  Padding(
                    padding: EdgeInsets.only(top: 66, bottom: 25),
                    child: Text(
                      "USD " + _cotacaoCompraUsd,
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 66),
                    child: Text(
                      "BRL " + _cotacaoCompraBrl,
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: Colors.orange,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                    child: Text(
                      "Atualizar",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    onPressed: (){
                      setState(() {
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
