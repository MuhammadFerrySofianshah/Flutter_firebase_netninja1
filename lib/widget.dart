import 'package:flutter/material.dart';

/// Colors
Color redColor = Colors.red;
Color blackColor = Colors.black;
Color whiteColor = Colors.white;
Color greenColor = Colors.green;
Color orangeColor = Colors.orange;
Color blueColor = const Color(0xff87cefa);
Color bgColor = const Color(0xffD7CCC9);

/// Text
Widget wText(text, color, fontSize, fontWeight) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ), 
  );
}

/// SizeBox
Widget wSizedBoxHeight(height) {
  return SizedBox(
    height: height,
  );
}

// NAVIGATOR PUSH
Future wPush(context, page) {
  return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ));
}

// NAVIGATOR PUSH
Future wPushReplacement(context, page) {
  return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ));
}

///  NOTIFIKASI COY
dynamic wShowDialog(context, text, color) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          content: Center(
            child: Text(
                    text,
                    style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none),
                  ),
          ));
    },
  );
}
