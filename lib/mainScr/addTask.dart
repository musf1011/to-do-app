import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/mainScr/mainScreen.dart';

class Addtask extends StatelessWidget {
  Addtask({super.key});

  TextEditingController todo = TextEditingController();

  Future<List<String>> to_do_list() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList('dbToDoList') ?? [];
  }

  Future<void> saveToDoList(List<String> toDoList) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList('dbToDoList', toDoList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 123, 198, 123),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add To Do',
          style: TextStyle(
              fontSize: 30, color: Color.fromARGB(255, 123, 198, 123)),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 60, 15, 30),
            child: TextField(
              controller: todo,
              maxLines: 2,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)),
                labelText: 'Describe Task',
                hintText: 'Gym time.....',
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          // GestureDetector(
          //   onTap: () async {
          //     List<String> toDoList = await to_do_list();
          //     print(toDoList);
          //     showDialog(
          //       context: context,
          //       builder: (context) => AlertDialog(
          //         title: Text('Saved Successfully'),
          //         content: Text(toDoList.join(', ')),
          //       ),
          //     );
          //   },

          //   child: Container(
          //     width: 200,
          //     height: 50,
          //     decoration: BoxDecoration(
          //       color: Colors.amber, borderRadius: BorderRadius.circular(50),
          //     ),
          //     child: Center(child: Text('Show To Do')),
          //   ),
          // ),
          // SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              List<String> toDoList = await to_do_list();
              toDoList.add(todo.text);
              await saveToDoList(toDoList);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainScreen()));
            },
            child: Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                  child: Text('Save To Do',
                      style: TextStyle(
                        fontSize: 24,
                      ))),
            ),
          ),
          SizedBox(
            height: 30,
          ),

          GestureDetector(
            onTap: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => MainScreen()));
            },
            child: Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                  child: Text(
                'Cancel',
                style: TextStyle(fontSize: 24),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
