import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpSample extends StatefulWidget {
  const HttpSample({super.key});

  @override
  State<HttpSample> createState() => _HttpSampleState();
}

class _HttpSampleState extends State<HttpSample> {
  final httpForApi = TextEditingController();
  final fieldString = TextEditingController();

  void initState() {
    super.initState();
  }

  Future<String> fetchData(String httpApi, String fieldString) async {
    final url = Uri.parse(httpApi);

    String resultString = "";

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        resultString = data.toString();

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data[fieldString])));
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }

    return resultString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Http Request'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                      controller: httpForApi,
                      obscureText: false,
                      decoration: InputDecoration(
                          hintText: 'Enter Http Sample',
                          fillColor: Color(0xffE7E1E1),
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none)))),
              Container(
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                      controller: fieldString,
                      obscureText: false,
                      decoration: InputDecoration(
                          hintText: 'Field with String Value',
                          fillColor: Color(0xffE7E1E1),
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none)))),
              GestureDetector(
                onTap: () => {fetchData(httpForApi.text, fieldString.text)},
                child: Container(
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 20,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xff0D3E50),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text('Get Value',
                            style: TextStyle(color: Colors.white)))),
              )
            ]))));
  }
}
