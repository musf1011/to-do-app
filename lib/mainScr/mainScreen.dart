import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/auth/welcomeScreen.dart';
import 'package:to_do_app/mainScr/addTask.dart';
import 'package:to_do_app/mainScr/profile.dart';
import 'package:to_do_app/utils/profInfo.dart';
import 'package:to_do_app/utils/toastPopUp.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FirebaseAuth authentication = FirebaseAuth.instance;

  //final _database = FirebaseDatabase.instance.ref('userDetails');

// real time database instance  creating
  final _database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://to-do-app-dc50e-default-rtdb.firebaseio.com",
  ).ref('userDetails');

  // @override
  // void initState() {
  //   super.initState();
  //   toDoList = to_do_list();
  // }

  // Future<List<String>> to_do_list() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   return pref.getStringList('dbToDoList') ?? [];
  // }

  // Future<void> saveToDoList(List<String> toDoList) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setStringList('dbToDoList', toDoList);
  // }

  // late Future<List<String>> toDoList;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final fStore = FirebaseFirestore.instance.collection('ToDo').snapshots();

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
              Text(
                'To Do List',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Addtask()));
        },
        child: Icon(
          Icons.add,
          color: Colors.amber,
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 182, 146, 29),
        child: Column(
          children: [
            Container(
              height: .31.sh,
              width: 1.sw,
              color: Colors.black,
              child: ProfInfo(),
            ),
            SizedBox(height: 0.01.sh),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                onTap: () {
                  authentication.signOut().then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Welcome()));
                  }).onError((Error, value) {
                    ToastPopUp().toastPopUp(Error.toString(), Colors.amber);
                  });
                },
                //style: ListTileStyle.drawer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black)),
                contentPadding: EdgeInsets.symmetric(horizontal: 25),
                horizontalTitleGap: 40,
                hoverColor: const Color.fromARGB(255, 123, 94, 6),
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text('Log Out',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  'credentials will be required again',
                  style: TextStyle(fontSize: 8.sp),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                onTap: () {
                  authentication.currentUser!.delete().then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Welcome()));
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black)),
                contentPadding: EdgeInsets.symmetric(horizontal: 25),
                horizontalTitleGap: 40,
                hoverColor: const Color.fromARGB(255, 123, 94, 6),
                leading: Icon(
                  Icons.no_accounts_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text('Delete Account',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  'All you data will be also deleted',
                  style: TextStyle(fontSize: 8.sp),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                //style: ListTileStyle.drawer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black)),
                contentPadding: EdgeInsets.symmetric(horizontal: 25),
                horizontalTitleGap: 40,
                hoverColor: const Color.fromARGB(255, 123, 94, 6),
                leading: Icon(
                  Icons.account_box_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text('Profile',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  'Account information',
                  style: TextStyle(fontSize: 8.sp),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body:
          //  SingleChildScrollView(
          //   child:
          Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'search'),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: fStore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, Index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  (Index + 1).toString(),
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
                                        snapshot.data!.docs[Index].reference
                                            .delete();
                                        fireStore
                                            .collection('ToDo')
                                            .doc('ID')
                                            .delete();
                                        // fireStore.collection('ToDo').doc(snapshot.data!.docs['ID']).,
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
                                    snapshot.data!.docs[Index]['Task'],
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
                );
                //       );
              }),
        ],
      ),
      //),
    );
  }
}
