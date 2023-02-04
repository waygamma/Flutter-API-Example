import 'dart:convert';
import 'package:apinetwork_app/model/books_response.dart';
import 'package:apinetwork_app/model/simple_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SamplePage extends StatefulWidget {
  const SamplePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  int _counter = 0;

  void _incrementCounter() {
    _counter++;
    setState(() {});
  }

  Map<String, dynamic>? responseApi;
  Album? parsedResponse;
  fetchApi() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/albums/1');
    var response = await http.post(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      responseApi = jsonDecode(response.body);
      print(responseApi!["id"]);
      parsedResponse = Album.fromJson(responseApi!);
    } else {
      print('Request failed with status Code: ${response.statusCode}.');
    }
    setState(() {});
  }

  List<Widget> ListOfBook = [];
  BooksResponse? books;
  fetchApiBook() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response = await http.post(
      url,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json!["id"]);
      print("status Code: ${response.statusCode}");
      books = BooksResponse.fromJson(json!);
      books!.books.forEach((item) {
        final widget = Container(
          margin: EdgeInsets.symmetric(
            vertical: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: Row(
            children: [
              Image.network(
                item.image,
                width: 100,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Details: ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

        ListOfBook.add(widget);
      });
    } else {
      print('Request failed with status Code: ${response.statusCode}.');
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchApi();
    fetchApiBook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [...ListOfBook],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
