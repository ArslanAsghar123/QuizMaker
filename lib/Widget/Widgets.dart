import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 20),
        children: <TextSpan>[
          TextSpan(
              text: 'Quiz',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.black,fontFamily: 'PTSans')),
          TextSpan(
              text: 'Makers',
              style:
                  TextStyle(fontWeight: FontWeight.w800, color: Colors.blue,fontFamily: 'Quicksand')),
        ],
      ),
    ),
  );
}

Widget blueButton({BuildContext context, String lable,}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    decoration: BoxDecoration(
        color: Colors.blue, borderRadius: BorderRadius.circular(30)),
    width: MediaQuery.of(context).size.width - 48,
    alignment: Alignment.center,
    child: Text(
      lable,
      style: TextStyle(fontSize: 16.0, color: Colors.white),
    ),
  );
}
