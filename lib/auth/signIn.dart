import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/auth/signUp.dart';
import 'package:to_do_app/auth/welcomeScreen.dart';
import 'package:to_do_app/mainScr/mainScreen.dart';
import 'package:to_do_app/utils/toastPopUp.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailCont = TextEditingController();

  final TextEditingController passcont = TextEditingController();

  bool _isPasswordVisible = false;

  int cred = 1;

  bool isLoading = false;

  final keyOfForm = GlobalKey<FormState>();

  FirebaseAuth authentic = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: 1.sh,
      width: 1.sw,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.amber, Colors.black])),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(.005.sw, .015.sh, .05.sw, 0),
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
            padding: EdgeInsets.fromLTRB(0, 0, .55.sw, .1.sh),
            child: Text(
              'Hello\nSign in!',
              style: TextStyle(fontSize: 30.sp, color: Colors.white),
            ),
          ),
          Form(
            key: keyOfForm,
            child: Container(
              height: .687.sh,
              width: 1.sw,
              decoration: BoxDecoration(
                  color: Color.fromARGB(250, 225, 250, 250),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.fromLTRB(.05.sw, .05.sh, .05.sw, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Gmail field should be filled';
                        }
                        return null;
                      },
                      controller: emailCont,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Gmail',
                        hintText: 'you@gmail.com',
                        hintStyle: TextStyle(
                            color: const Color.fromARGB(255, 226, 222, 209)),
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 182, 146, 29)),
                        suffixIcon: Icon(
                          Icons.check,
                          color: cred == 0 ? Colors.red : Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 182, 146, 29)),
                        ),
                      ),
                    ),
                    SizedBox(height: .05.sh),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Passwrd field should be filled';
                        }
                        return null;
                      },
                      obscureText: _isPasswordVisible == false ? true : false,
                      controller: passcont,
                      decoration: InputDecoration(
                        hintText: 'password',
                        hintStyle: TextStyle(
                            color: const Color.fromARGB(255, 226, 222, 209)),
                        labelText: 'Password',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 182, 146, 29)),
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
                              color: Color.fromARGB(255, 182, 146, 29)),
                        ),
                      ),
                    ),
                    SizedBox(height: 0.01.sh),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                      ),
                    ),
                    SizedBox(height: .01.sh),
                    cred == 0
                        ? Text('*Complete the credentials',
                            style: TextStyle(
                                color: Color.fromARGB(255, 123, 100, 22),
                                fontSize: 12.sp))
                        : cred == 2
                            ? Text('*Incorrect Password',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 123, 100, 22),
                                    fontSize: 12.sp))
                            : SizedBox(
                                height: 0.03.sh,
                              ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        String g = emailCont.text;
                        String p = passcont.text;

                        // SharedPreferences prefs =
                        //     await SharedPreferences.getInstance();
                        // String? em = prefs.getString('email');
                        // String? ps = prefs.getString('pass');

                        if (g == '' || p == '') {
                          setState(() {
                            cred = 0;
                          });
                          print('is empty');
                        } else if (keyOfForm.currentState!.validate()) {
                          authentic
                              .signInWithEmailAndPassword(
                            email: emailCont.toString().trim(),
                            password: passcont.toString().trim(),
                          )
                              .then((Value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainScreen()));
                            setState(() {
                              isLoading = false;
                            });
                          }).onError((Error, Value) {
                            ToastPopUp()
                                .toastPopUp(Error.toString(), Colors.black);
                            setState(() {
                              isLoading = false;
                            });
                          });
                        }
                        setState(() {
                          isLoading = false;
                        });
                        print(emailCont.text);
                      },
                      child: Container(
                        height: .075.sh,
                        width: .75.sw,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.amber, Colors.black]),
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                            child: isLoading == true
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'SIGN IN',
                                    style: TextStyle(
                                        fontSize: 18.sp, color: Colors.white),
                                  )),
                      ),
                    ),
                    SizedBox(height: .2.sh),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                        SizedBox(width: 8.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                color: Color.fromARGB(255, 111, 236, 111)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
