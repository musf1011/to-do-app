import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/auth/signIn.dart';
import 'package:to_do_app/auth/welcomeScreen.dart';
import 'package:to_do_app/mainScr/mainScreen.dart';
import 'package:to_do_app/utils/toastPopUp.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController fullname = TextEditingController();

  final TextEditingController emailContr = TextEditingController();

  final TextEditingController passw = TextEditingController();

  final TextEditingController cpassw = TextEditingController();

  int password =
      -1; // 0: mismatch, 1: match, 2: empty password, 3: empty confirm password

  int gmail = -1;

  int fullName = -1;
  bool _isPasswordVisible = false;

  bool isLoading = false;

  final keyOfForm = GlobalKey<FormState>();

  FirebaseAuth authent = FirebaseAuth.instance;

  //DatabaseReference dbr = FirebaseDatabase.instance.ref('userDetails');

  final _database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://to-do-app-dc50e-default-rtdb.firebaseio.com",
  ).ref('userDetails');

  //final FStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.amber, Colors.black])),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(.008.sh, .015.sh, .05.sw, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Welcome()));
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: .05.sh,
                      )),
                  Icon(Icons.more_horiz, color: Colors.white, size: .04.sh)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, .4.sw, .05.sh),
              child: Text(
                'Create Your\nAccount',
                style: TextStyle(fontSize: 30.sp, color: Colors.white),
              ),
            ),
            Form(
              key: keyOfForm,
              child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(250, 225, 250, 250),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0.05.sw, .02.sh, .05.sw, 0),
                      child: Column(children: [
                        fullName == 0
                            ? Text('*Full Name can\'t be empty',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 113, 12, 31),
                                    fontSize: 12.sp))
                            : SizedBox(
                                height: 0.03.sh,
                              ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your Full Name';
                            }
                            return null;
                          },
                          controller: fullname,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            hintText: 'Billy Boy',
                            hintStyle: TextStyle(
                                color:
                                    const Color.fromARGB(255, 226, 222, 209)),
                            labelStyle: TextStyle(
                                color: const Color.fromARGB(255, 182, 146, 29)),
                            suffixIcon: Icon(
                              Icons.check,
                              color: fullName == 1 ? Colors.green : Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 182, 146, 29)),
                            ),
                          ),
                        ),
                        gmail == 0
                            ? Text('*Phone or Gmail can\'t be empty',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 113, 12, 31),
                                    fontSize: 12.sp))
                            : SizedBox(
                                height: 0.03.sh,
                              ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter an Valid Email or Phone No';
                            }
                            return null;
                          },
                          controller: emailContr,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Phone or Gmail',
                            hintText: 'you@gmail.com',
                            hintStyle: TextStyle(
                                color:
                                    const Color.fromARGB(255, 226, 222, 209)),
                            labelStyle: TextStyle(
                                color: const Color.fromARGB(255, 182, 146, 29)),
                            suffixIcon: Icon(
                              Icons.check,
                              color: gmail == 1 ? Colors.green : Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 182, 146, 29)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: .03.sh,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password can not be empty';
                            }
                            return null;
                          },
                          obscureText:
                              _isPasswordVisible == false ? true : false,
                          controller: passw,
                          decoration: InputDecoration(
                            hintText: 'password',
                            hintStyle: TextStyle(
                                color:
                                    const Color.fromARGB(255, 226, 222, 209)),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: const Color.fromARGB(255, 182, 146, 29)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: _isPasswordVisible == false
                                    ? Colors.grey
                                    : Color.fromARGB(255, 123, 100, 22),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 182, 146, 29)),
                            ),
                          ),
                        ),
                        password == 0
                            ? (Text('*Passwords doesn\'t match',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 113, 12, 31),
                                    fontSize: 12.sp)))
                            : (password == 2
                                ? Text('*Passwords can\'t be empty',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 113, 12, 31),
                                        fontSize: 12.sp))
                                : (password == 3
                                    ? Text('*Confirm your Password',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 113, 12, 31),
                                            fontSize: 12.sp))
                                    : SizedBox(
                                        height: 0.03.sh,
                                      ))),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Confirm your Password';
                            }
                            return null;
                          },
                          obscureText:
                              _isPasswordVisible == false ? true : false,
                          controller: cpassw,
                          decoration: InputDecoration(
                            hintText: 'password',
                            hintStyle: TextStyle(
                                color:
                                    const Color.fromARGB(255, 226, 222, 209)),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: const Color.fromARGB(255, 182, 146, 29)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: _isPasswordVisible == false
                                    ? Colors.grey
                                    : Color.fromARGB(255, 123, 100, 22),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 182, 146, 29)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: .087.sh,
                        ),
                        GestureDetector(
                          onTap: () async {
                            // Perform asynchronous operations outside of setState
                            String fn = fullname.text;
                            String gm = emailContr.text;
                            String pw = passw.text;
                            String cpw = cpassw.text;
                            int gmailStatus = gm.isNotEmpty ? 1 : 0;
                            int fullNameStatus = fn.isNotEmpty ? 1 : 0;
                            int passwordStatus;

                            if (pw.isEmpty) {
                              passwordStatus = 2; // Password is empty
                            } else if (cpw.isEmpty) {
                              passwordStatus = 3; // Confirm password is empty
                            } else if (pw != cpw) {
                              passwordStatus = 0; // Passwords don't match
                            } else {
                              passwordStatus = 1; // Passwords match
                            }
                            // Update the UI inside setState
                            setState(() {
                              gmail = gmailStatus;
                              fullName = fullNameStatus;
                              password = passwordStatus;
                              isLoading = true;
                            });

                            if (passwordStatus == 1 &&
                                fullNameStatus == 1 &&
                                gmailStatus == 1 &&
                                keyOfForm.currentState!.validate()) {
                              authent
                                  .createUserWithEmailAndPassword(
                                      email: emailContr.text.toString().trim(),
                                      password: passw.text.toString().trim())
                                  .then((value) {
                                DateTime currentDnT = DateTime.now();
                                _database.child(value.user!.uid).set({
                                  'fullName': fullname.text.toString().trim(),
                                  'email': emailContr.text.toString().trim(),
                                  'password': passw.text.toString().trim(),
                                  'time': currentDnT.toIso8601String(),
                                  'userID': value.user!.uid
                                });
                                ToastPopUp().toastPopUp(
                                    'Sign Up Successful', Colors.black);

                                // Navigate to SignIn screen or other screen after saving data
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen()));

                                setState(() {
                                  isLoading = false;
                                });
                                fullname.clear();
                                emailContr.clear();
                                passw.clear();
                                cpassw.clear();
                              }).onError((error, value) {
                                ToastPopUp()
                                    .toastPopUp(error.toString(), Colors.black);
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          child: Container(
                            width: .75.sw,
                            height: .075.sh,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.amber, Colors.black]),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: isLoading == true
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text('SIGN UP',
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: .07.sh,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 12.sp),
                            ),
                            SizedBox(width: 8.0),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()));
                              },
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 111, 236, 111)),
                              ),
                            ),
                          ],
                        ),
                      ]))),
            ),
          ])),
    ));
  }
}
