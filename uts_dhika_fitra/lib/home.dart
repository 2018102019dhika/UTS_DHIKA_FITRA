import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List _get = [];

  final _lightColors = [
    const Color.fromARGB(255, 255, 0, 0),
    const Color.fromARGB(255, 255, 187, 0),
    const Color.fromARGB(255, 255, 0, 0)
  ];

  @override
  void initState() {
    super.initState();

    _getData();
  }

  Future _getData() async {
    try {
      final response =
          await http.get(Uri.parse("http://192.168.43.195/restapi-karyawan"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _get = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Company'),
        backgroundColor: const Color.fromARGB(0, 201, 250, 168),
        centerTitle: true,
        titleSpacing: 12,
      ),
      body: _get.isNotEmpty
          ? MasonryGridView.count(
              crossAxisCount: 1,
              itemCount: _get.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push;
                  },
                  child: Card(
                    color: _lightColors[index % _lightColors.length],
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 100),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_get[index]['id']}',
                            style: const TextStyle(color: Colors.black),
                          ),
                          Text(
                            '    Name     : '
                            '${_get[index]['name']}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '    Address : '
                            '${_get[index]['address']}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '    Salary     : '
                            '${_get[index]['salary']}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () {},
                              child: const Text(
                                "Detail",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text(
                "No Data Available",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
