import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(httpWork());

class httpWork extends StatefulWidget {
  const httpWork({super.key});

  @override
  State<httpWork> createState() => _httpWorkState();
}

class _httpWorkState extends State<httpWork> {
  final url =
      "https://login-test-98bcc-default-rtdb.asia-southeast1.firebasedatabase.app/test";

  void getting() async {
    final getreq = await http.get(Uri.parse(url + ".json"));
    final response = jsonDecode(getreq.body) as Map<String, dynamic>;
    print(response);
  }

  void posting() async {
    http.post(
      Uri.parse(url + '.json'),
      body: jsonEncode(
        {
          'text': 'hellow guys',
        },
      ),
      headers: {'Content-Type': 'application/json'},
    ).catchError((onErro) => print(onErro));
  }

  void deleteing() async {
    print("triggerd");
    http.delete(Uri.parse(url + "/-NH0LZ-6LjiBMH263bRi.json"));
  }

  void updating() async {
    http.patch(
      Uri.parse(url + "/-NH0RJMOCrPUFvF2cH5Z.json"),
      body: jsonEncode(
        {
          'text': 'sorry guys',
        },
      ),
      headers: {'Content-Type': 'application/json'},
    ).catchError((onErro) => print(onErro));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "http working",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          leading: BackButton(color: Colors.blueGrey),
          elevation: 5,
          centerTitle: true,
          title: Text("RealTime DB"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    getting();
                  },
                  child: Text("GET"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    posting();
                  },
                  child: Text("post"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    updating();
                  },
                  child: Text("PUT"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    deleteing();
                  },
                  child: Text("DELTE"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
