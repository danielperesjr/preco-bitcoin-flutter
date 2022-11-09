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

  String _cotacaoCompraUsd = "0.00";
  String _cotacaoCompraBrl = "0.00";

  void _recuperarPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
      _cotacaoCompraUsd = retorno["USD"]["buy"].toString();
      _cotacaoCompraBrl = retorno["BRL"]["buy"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 66),
                child: Text(
                  "BRL " + _cotacaoCompraBrl,
                  style: TextStyle(
                    fontSize: 40,
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
                  onPressed: _recuperarPreco,
              )
            ],
          ),
        ),
      ),
    );
  }
}
