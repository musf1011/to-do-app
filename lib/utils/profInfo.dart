// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ProfInfo extends StatefulWidget {
//   ProfInfo({
//     super.key,
//   });

//   @override
//   State<ProfInfo> createState() => _ProfInfoState();
// }

// class _ProfInfoState extends State<ProfInfo> {
//   late Query query;

//   FirebaseAuth authent = FirebaseAuth.instance;

//   final _database = FirebaseDatabase.instanceFor(
//     app: Firebase.app(),
//     databaseURL: "https://to-do-app-dc50e-default-rtdb.firebaseio.com",
//   ).ref('userDetails');

//   void initState() {
//     query = _database.orderByChild('userID').equalTo(authent.currentUser!.uid);
//     print('Initialized Query for UID: ${authent.currentUser!.uid}');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(height: 0.01.sh),
//         CircleAvatar(
//           maxRadius: 40,
//           child: Icon(
//             Icons.person_4,
//             size: 60,
//           ),
//         ),
//         SizedBox(height: 0.02.sh),
//         Expanded(
//           child: FirebaseAnimatedList(
//               query: query,
//               defaultChild: Center(child: CircularProgressIndicator()),
//               itemBuilder: (context, snapshot, animation, index) {
//                 print('Snapshot: ${snapshot.value}');
//                 if (snapshot.hasChild('fullName')) {
//                   return Column(
//                     children: [
//                       Text(
//                         snapshot.child('fullName').value.toString(),
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       SizedBox(height: 0.05.sh),
//                       Text(
//                         snapshot.child('email').value.toString(),
//                         style: TextStyle(color: Colors.white, fontSize: 12.sp),
//                       )
//                     ],
//                   );
//                 } else {
//                   return Text('no full name available');
//                 }
//               }),
//         )
//       ],
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfInfo extends StatefulWidget {
  @override
  State<ProfInfo> createState() => _ProfInfoState();
}

class _ProfInfoState extends State<ProfInfo> {
  late Query query;
  FirebaseAuth authent = FirebaseAuth.instance;

  // final _database = FirebaseDatabase.instance.ref('userDetails');

  final _database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://to-do-app-dc50e-default-rtdb.firebaseio.com",
  ).ref('userDetails');

  void initState() {
    super.initState();
    // var snap = _database.child(FirebaseAuth.instance.currentUser!.uid).get();

    query = _database.orderByChild('userID').equalTo(authent.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 0.01.sh),
      CircleAvatar(
        maxRadius: 40,
        child: Icon(
          Icons.person_4,
          size: 60,
        ),
      ),
      SizedBox(height: 0.02.sh),
      SizedBox(
        height: 100, // Set a fixed height for the ProfInfo
        child: FirebaseAnimatedList(
          query: query,
          itemBuilder: (context, snapshot, _, index) {
            return Column(
              children: [
                Text(
                  snapshot.child('fullName').value.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
                SizedBox(height: 20),
                Text(
                  snapshot.child('email').value.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            );
          },
        ),
      )
    ]);
  }
}
