// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'qrview.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage()
    },
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textQrController = TextEditingController();
  final textpassController = TextEditingController();
  String railfenceEncrypt(String text, int key) {
    int row = key, col = text.length, x = 0, y = 0;
    String result = '';
    bool dir = false;
    var matrix = List.generate(row, (i) => List.generate(col, (_) => ""));
    for (var i = 0; i < text.length; i++) {
      if (x == 0 || x == row - 1) dir = !dir;
      matrix[x][y++] = text[i];
      dir ? x++ : x--;
    }
    for (var i = 0; i < row; i++) {
      for (var j = 0; j < col; j++) {
        if (matrix[i][j] != null) result += matrix[i][j];
      }
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("QR Code Example"),
          actions: const [],
        ),
        body: Column(
          children: [
            TextField(
              controller: textQrController,
              decoration: const InputDecoration(
                label: Text('Input Text QR Code'),
              ),
            ),
            TextField(
              controller: textpassController,
              decoration: const InputDecoration(
                label: Text('Input Rails'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                String data = railfenceEncrypt(textQrController.text, int.parse(textpassController.text));
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return QRView(textQR: data);
                  },
                ));
              },
              child: const Text('Generate QR Code'),
            )
          ],
        ));
  }
}