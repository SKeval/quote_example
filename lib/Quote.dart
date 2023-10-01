// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:quote_ex/Common/msg.dart';
import 'package:quote_ex/TaskVariable/Variable.dart';

class Quote extends StatefulWidget {
  const Quote({Key? key}) : super(key: key);

  @override
  State<Quote> createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  List<QuoteVariable> quots = [];
  List<Color> colos = [
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.blueGrey,
    Colors.purple,
    Colors.pink,
    Colors.brown
  ];
  TextEditingController quotecon = TextEditingController();
  TextEditingController authorcon = TextEditingController();
  int select = -1;

  showbottom() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showMsg(context, "View Closed", c: Colors.green);
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        ElevatedButton(
                            onPressed: () {
                              colos.shuffle();
                              setState(() {
                                if (select != -1) {
                                  showMsg(context, "Data Updated",
                                      c: Colors.green[200]!);
                                  quots[select].quotes = quotecon.text.trim();
                                  quots[select].author = authorcon.text.trim();
                                  quotecon.clear();
                                  authorcon.clear();
                                  select = -1;
                                } else {
                                  showMsg(context, "Data Added",
                                      c: Colors.green[200]!);
                                  quots.add(QuoteVariable(
                                      quotes: quotecon.text.trim(),
                                      author: authorcon.text.trim(),
                                      c: colos[0]));
                                  quotecon.clear();
                                  authorcon.clear();
                                }
                              });
                              Navigator.pop(context);
                            },
                            child: select != -1
                                ? const Text("Update")
                                : const Text("Add")),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  //box for qoutes
  qouteBox(QuoteVariable q, int index) {
    return Stack(
      children: [
        Container(
          height: 200,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: q.c,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  q.quotes,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "- ${q.author}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(14),
            height: 80,
            child: Column(
              children: [
                const Divider(
                  thickness: 0.5,
                  color: Colors.black,
                  height: 1,
                ),
                Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          print('text clicked');
                        },
                        child: Text(
                          "${quots[index].count}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  showMsg(context, "Data Deleted");
                                  quots.removeAt(index);
                                });
                              },
                              icon: const Icon(Icons.delete)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  select = index;
                                  quotecon.text = quots[select].quotes;
                                  authorcon.text = quots[select].author;
                                  showbottom();
                                });
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                q.count++;
                              });
                            },
                            icon: Image.asset(
                              'assets/img/heart.png',
                              height: 25,
                              width: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
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
                  int count = 0;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 0,
                      child: qouteBox(quots[index], index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showbottom();
          },
          child: Image.asset(
            'assets/img/quote.png',
            height: 20,
            width: 20,
          ),
        ));
  }

  /*

Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: quots[index].c,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: ListTile(
                                  title: Center(
                                    child: Text(
                                      quots[index].quotes,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  subtitle: Center(
                                    child: Text(
                                      "- ${quots[index].author}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 0.5,
                              color: Colors.black,
                              height: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "${quots[index].count}",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                showMsg(
                                                    context, "Data Deleted");
                                                quots.removeAt(index);
                                              });
                                            },
                                            icon: const Icon(Icons.delete)),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                select = index;
                                                quotecon.text =
                                                    quots[select].quotes;
                                                authorcon.text =
                                                    quots[select].author;
                                                showbottom();
                                              });
                                            },
                                            icon: const Icon(Icons.edit)),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              quots[index].count++;
                                            });
                                          },
                                          icon: Image.asset(
                                            'assets/img/heart.png',
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),


  */
}

/*

*/

/*
Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Card(
                     
                      child: SizedBox(
                        height: 200,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: ListTile(
                            title: Text(
                              quots[index].quotes,
                              style: const TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              "- ${quots[index].author}",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            /*
                            trailing: SizedBox(
                              height: 100,
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          showMsg(context, "Data Deleted");
                                          quots.removeAt(index);
                                        });
                                      },
                                      icon: const Icon(Icons.delete)),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          select = index;
                                          quotecon.text = quots[select].quotes;
                                          authorcon.text = quots[select].author;
                                        });
                                      },
                                      icon: const Icon(Icons.edit)),
                                  FloatingActionButton(
                                    onPressed: () {
                                      showbottom();
                                    },
                                    child: Image.asset(
                                      'assets/img/heart.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          */
                          ),
                        ),
                      ),
                    ),
                  );
*/
