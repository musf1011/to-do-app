import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/mainScr/addTask.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    toDoList = to_do_list();
  }

  Future<List<String>> to_do_list() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList('dbToDoList') ?? [];
  }

  Future<void> saveToDoList(List<String> toDoList) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList('dbToDoList', toDoList);
  }

  late Future<List<String>> toDoList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('To Do List'),
        backgroundColor: const Color.fromARGB(255, 123, 198, 123),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<String>>(
          future: toDoList,
          builder: (context, snapshot) {
            final items = snapshot.data!;
            if (items != null) {
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '${index + 1}:',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 350,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          items.removeAt(index);
                                          saveToDoList(items);
                                        });
                                      },
                                      child: Icon(
                                        Icons.delete_forever,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 500,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.amber,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 12, 6, 2),
                                    child: Text(
                                      items[index],
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          );
                        }),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 6),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Color.fromARGB(255, 123, 198, 123)),
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Addtask()));
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              )),
                        ),
                      )
                    ],
                  )
                ],
              );
            } else {
              return Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Addtask()));
                      },
                      child: Icon(Icons.add))
                ],
              );
            }
          }),
    );
  }
}
