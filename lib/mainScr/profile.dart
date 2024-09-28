// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:to_do_app/utils/profInfo.dart';

// class Profile extends StatelessWidget {
//   Profile({super.key});

//   final _database = FirebaseDatabase.instanceFor(
//     app: Firebase.app(),
//     databaseURL: "https://to-do-app-dc50e-default-rtdb.firebaseio.com",
//   ).ref('userDetails');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [ProfInfo()],
//     )

//         // SingleChildScrollView(
//         //   child: Column(
//         //     children: [
//         //       Container(
//         //         width: 1.sw,
//         //         height: .4.sh,
//         //         decoration: BoxDecoration(
//         //             gradient:
//         //                 LinearGradient(colors: [Colors.amber, Colors.black])),
//         //         child: Column(
//         //           children: [
//         //             Padding(
//         //               padding:
//         //                   EdgeInsets.fromLTRB(.005.sw, .015.sh, .90.sw, .01.sh),
//         //               child: GestureDetector(
//         //                 onTap: () {
//         //                   Navigator.pop(context);
//         //                 },
//         //                 child: Icon(
//         //                   Icons.arrow_back,
//         //                   size: 30,
//         //                 ),
//         //               ),
//         //             ),
//         //             ProfInfo(),
//         //           ],
//         //         ),
//         //       ),
//         //       Container(
//         //         width: 1.sw,
//         //         height: .6.sh,
//         //         color: Colors.black,
//         //         child: Text('This account is created on '),
//         //       )
//         //     ],
//         //   ),
//         // ),
//         );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/utils/profInfo.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth authent = FirebaseAuth.instance;

  late Query query;

  final _database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://to-do-app-dc50e-default-rtdb.firebaseio.com",
  ).ref('userDetails');

  void initState() {
    super.initState();
    query = _database.orderByChild('userID').equalTo(authent.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top container for profile info
            Container(
              width: 1.sw,
              height: 0.4.sh, // Fixed height
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber, Colors.black],
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(.005.sw, .015.sh, .90.sw, .01.sh),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                  ),
                  // Directly using ProfInfo without Expanded
                  ProfInfo(), // Make sure ProfInfo does not have flex properties
                ],
              ),
            ),
            // Bottom container for account details
            Container(
              width: 1.sw,
              height: 0.6.sh, // Fixed height
              color: Colors.black,
              child: FirebaseAnimatedList(
                  query: query,
                  itemBuilder: (context, snapshot, animation, index) {
                    return Row(
                      children: [
                        Center(
                          child: Text(
                            'This account is created on ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Text(
                          snapshot.child('time').value.toString(),
                          style: TextStyle(color: Colors.amber),
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
