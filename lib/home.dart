import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Home extends StatefulWidget {

  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco = "0000,00";
  void _getPreco () async{
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = jsonDecode(response.body);
    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
    });
    // print(retorno["BRL"]["buy"].toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(''),),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/bitcoin.png"),
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                  child: Text(
                    "R\$ " + _preco,
                    style: TextStyle(fontSize: 35),
                  ),
                ),
               ElevatedButton(
                onPressed: () => _getPreco(),
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15)),
                child: Text(
                  "Atualizar",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}