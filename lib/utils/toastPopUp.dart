import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastPopUp {
  void toastPopUp(
    message,
    tCOlor,
  ) {
    Fluttertoast.showToast(
        msg: message,
        textColor: tCOlor,
        backgroundColor: Color.fromARGB(255, 182, 146, 29),
        fontSize: 16.sp,
        timeInSecForIosWeb: 5,
        gravity: ToastGravity.TOP_LEFT);
  }
}
