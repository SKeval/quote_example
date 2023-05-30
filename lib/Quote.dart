// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:quote_ex/Common/msg.dart';

class Quote extends StatefulWidget {
  const Quote({Key? key}) : super(key: key);

  @override
  State<Quote> createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  List<String> quots = [];
  List<Color> colos = [
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.blueGrey,
    Colors.purple,
    Colors.pink,
    Colors.brown
  ];
  List<String> author = [];
  TextEditingController quotecon = TextEditingController();
  TextEditingController authorcon = TextEditingController();
  int select = -1;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    quotecon.dispose();
    authorcon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 5,
                );
              },
              itemCount: quots.length,
              itemBuilder: (context, index) {
                colos.shuffle();
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                    color: colos[0],
                    child: ListTile(
                      title: Text(
                        quots[index],
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        "- ${author[index]}",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    showMsg(context, "Data Deleted");
                                    quots.removeAt(index);
                                    author.removeAt(index);
                                  });
                                },
                                icon: const Icon(Icons.delete)),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    select = index;
                                    quotecon.text = quots[select];
                                    authorcon.text = author[select];
                                  });
                                },
                                icon: const Icon(Icons.edit)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Card(
                        shadowColor: Colors.blue,
                        elevation: 5,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: quotecon,
                          decoration: const InputDecoration(
                            hintText: " Enter Quotes..",
                          ),
                        ),
                      ),
                      Card(
                        shadowColor: Colors.blue,
                        elevation: 5,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: authorcon,
                          decoration: const InputDecoration(
                            hintText: " Enter Author Name",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (select != -1) {
                              showMsg(context, "Data Updated",
                                  c: Colors.green[200]!);
                              quots[select] = quotecon.text.trim();
                              author[select] = authorcon.text.trim();
                              quotecon.clear();
                              authorcon.clear();
                              select = -1;
                            } else {
                              showMsg(context, "Data Added",
                                  c: Colors.green[200]!);
                              quots.add(quotecon.text.trim());
                              author.add(authorcon.text.trim());
                              quotecon.clear();
                              authorcon.clear();
                            }
                          });
                        },
                        child: select != -1 ? Text("Update") : Text("Add")),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
