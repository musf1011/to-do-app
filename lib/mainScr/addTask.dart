import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/mainScr/mainScreen.dart';
import 'package:to_do_app/utils/toastPopUp.dart';

class Addtask extends StatelessWidget {
  Addtask({super.key});

  TextEditingController todo = TextEditingController();

////shared preference database
  // Future<List<String>> to_do_list() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   return pref.getStringList('dbToDoList') ?? [];
  // }

  // Future<void> saveToDoList(List<String> toDoList) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setStringList('dbToDoList', toDoList);
  // }

  FirebaseAuth fAuth = FirebaseAuth.instance;

  FirebaseFirestore fStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 123, 198, 123),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add To Do',
          style:
              TextStyle(fontSize: 30, color: Color.fromARGB(255, 182, 146, 29)),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.amber, Colors.black]),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 60, 15, 30),
              child: TextField(
                controller: todo,
                maxLines: 3,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black)),
                  labelText: 'Describe Task',
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: 'Gym time.....',
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () async {
                // List<String> toDoList = await to_do_list();
                // toDoList.add(todo.text);
                // await saveToDoList(toDoList);

                String id = DateTime.now().millisecondsSinceEpoch.toString();
                if (todo.text.isEmpty) {
                  ToastPopUp().toastPopUp('Enter Data Please!', Colors.white);
                } else {
                  fStore.collection('ToDo').doc(id).set(
                      {"Task": todo.text.toString().trim(), "ID": id}).then(
                    (value) {
                      todo.clear();
                      ToastPopUp()
                          .toastPopUp('Task Added Succesfully', Colors.black);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()));
                    },
                  ).onError((error, v) {
                    ToastPopUp().toastPopUp(error.toString(), Colors.pink);
                  });
                }
              },
              child: Container(
                width: 300,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                    child: Text('Save To Do',
                        style: TextStyle(fontSize: 24, color: Colors.white
                            //Color.fromARGB(255, 182, 146, 29)
                            ))),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainScreen()));
              },
              child: Container(
                width: 300,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                    child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 24, color: Colors.white
                      // Color.fromARGB(255, 182, 146, 29)
                      ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
