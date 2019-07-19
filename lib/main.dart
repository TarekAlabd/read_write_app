import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

void main() async {
  var data = await readData();
  if(data != null) {
    print(data);
  }
  runApp(
    MaterialApp(
      title: "ReadWrite App",
      home: Home(),
    )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ReadWrite"
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(13.3),
        alignment: Alignment.topCenter,
        child: ListTile(
          title: TextField(
            controller: _enterFieldController,
            decoration: InputDecoration(
              labelText: "Enter something",
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(13.0),
            child: FlatButton(
                onPressed: () {
                  setState(() {
                    writeData(_enterFieldController.text);
                  });
                },
                child: Column(
                  children: <Widget>[
                    Text(
                      "Save data",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 17.9,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(14.5),
                    ),
                    FutureBuilder(
                      future: readData(),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if(snapshot.hasData != null) {
                          return Text(
                            snapshot.data.toString(),
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 17.9,
                            ),
                          );
                        } else{
                          return Text("No data Saved!");
                        }
                      },
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}


  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path; //home/directory/
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File("$path/data.txt");//home/directory/data.txt
  }

  //writing
  Future<File> writeData(String message) async {
   final file = await _localFile;
   return file.writeAsString("$message");
  }

  //Reading
Future<String> readData() async {
    try {
      final file = await _localFile;
      String data = await file.readAsString();
      return data;
    }catch(e) {
      return 'Nothing saved yet!';
  }
}

