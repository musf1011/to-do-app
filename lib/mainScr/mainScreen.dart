import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/auth/welcomeScreen.dart';
import 'package:to_do_app/mainScr/addTask.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            height: 80,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.amber, Colors.black])),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: 190,
              ),
              Text(
                'To Do List',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(130, 10, 10, 10),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Welcome()));
                    },
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                    )),
              )
            ]),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<String>>(
          future: toDoList,
          builder: (context, snapshot) {
            final items = snapshot.data!;
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '${index + 1}:',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 182, 146, 29),
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 350,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        items.removeAt(index);
                                        saveToDoList(items);
                                      });
                                    },
                                    child: const Icon(
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
                                    color: Color.fromARGB(255, 182, 146, 29)
                                    // gradient: LinearGradient(
                                    //     colors: [Colors.amber, Colors.black]),
                                    ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 12, 6, 2),
                                  child: Text(
                                    items[index],
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
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
                            color: Color.fromARGB(255, 182, 146, 29)),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Addtask()));
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            )),
                      ),
                    )
                  ],
                )
              ],
            );
          }),
    );
  }
}
