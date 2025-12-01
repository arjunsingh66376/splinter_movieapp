import 'package:flutter/material.dart';
import 'package:movies_app/widget/apiwidgets/searchbarapi.dart';
import 'package:movies_app/widget/apiwidgets/tvrecommendation.dart';
import 'package:movies_app/widget/normalwidgets/decoratedcards.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  TextEditingController searchcontro = TextEditingController();
  bool issearhing = false;

  @override
  void initState() {
    super.initState();
  }

  void closebtn() {
    searchcontro.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      issearhing = false;
    });
  }

  @override
  void dispose() {
    searchcontro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'search',
          style: TextStyle(fontFamily: 'pdark', color: Colors.red),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20),
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 15),
                ),
                backgroundColor: WidgetStatePropertyAll(Colors.white),
                hintText: 'what do you want to watch ?',
                controller: searchcontro,
                leading: issearhing
                    ? GestureDetector(
                        onTap: () => closebtn(),
                        child: Icon(Icons.close, color: Colors.red),
                      )
                    : Icon(Icons.search, color: Colors.red),
                hintStyle: WidgetStatePropertyAll(
                  TextStyle(color: Colors.black),
                ),

                // onChanged: (value) => setState(() => issearhing = true),
                onSubmitted: (value) {
                  setState(() {
                    issearhing = true;
                  });
                },
              ),

              SizedBox(height: 30),

              if (issearhing) ...[
                Searchbarapi(query: searchcontro.text.trim()),
              ] else ...[
                Text(
                  'start browsing ',
                  style: TextStyle(
                    fontFamily: 'pdark',
                    color: Colors.red,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Decoratedcards(),
                SizedBox(height: 20),
                Text(
                  'tv recommendation',
                  style: TextStyle(
                    fontFamily: 'pdark',
                    color: Colors.red,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Tvrecommendation(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
