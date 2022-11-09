import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _preco = "0";

  void _recuperarPreco() {

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
                  padding: EdgeInsets.only(top: 66, bottom: 66),
                child: Text(
                  "R\$ " + _preco,
                  style: TextStyle(
                    fontSize: 35
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
                      fontSize: 20,
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
