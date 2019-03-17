import 'package:flutter/material.dart';
import "dart:async";
import "dart:convert";
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJSON();
  runApp(MaterialApp(
      title: 'Intro Parse',
      home: Scaffold(
        appBar: AppBar(
          title: Text("JSON Parse"),
          centerTitle: true,
        ),
        body: Center(
            child: ListView.builder(
          itemCount: _data.length,
          padding: EdgeInsets.all(16.0),
          itemBuilder: (BuildContext context, int position) {
            if (position.isOdd)
              return Divider(
                color: Colors.black26,
              );
            final index = position ~/ 2;
            return ListTile(
              title: Text(
                "${_data[index]['title']}",
                style: TextStyle(fontSize: 13.0),
              ),
              subtitle: Text(
                "${_data[index]['body']}",
                style: TextStyle(color: Colors.black45, fontSize: 13.0),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.deepOrange,
                child: Text(
                    "${_data[index]["title"][0].toString().toUpperCase()}",
                    style: TextStyle(color: Colors.white)),
              ),
              onTap: () {
                _showOnTapMessage(context, "${_data[index]['title']}");
              },
            );
          },
        )),
      )));
}

void _showOnTapMessage(BuildContext context, String message) {
  var alert = AlertDialog(
    title: Text("app"),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Ok"),
      )
    ],
  );

showDialog(
  context: context,
  child: alert
);
}

Future<List> getJSON() async {
  String apiUrl = "https://jsonplaceholder.typicode.com/posts";
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}
