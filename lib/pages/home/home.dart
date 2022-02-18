import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../api/network.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final _url = Uri.parse('http://app-r.lsskincare.id/api/teams?page=1');

  Future<List<dynamic>> _teamsData() async {
    final result = await http.get(_url, headers: Network().setHeaders());
    return json.decode(result.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: _teamsData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://app-r.lsskincare.id/storage/teams/' +
                              snapshot.data[index]['image']),
                    ),
                    title: Text(snapshot.data[index]['name']),
                    subtitle: Text(snapshot.data[index]['email']),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
