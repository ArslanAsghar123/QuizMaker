import 'package:flutter/material.dart';
import 'package:quiz_maker/Widget/Widgets.dart';
import 'package:quiz_maker/view/home.dart';
import 'package:quiz_maker/view/quiz_play.dart';


class Result extends StatefulWidget {
  final int correct,incorrect,total;
  Result({@required this.correct,@required this.total,@required this.incorrect});

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${widget.correct}/${widget.total}",style: TextStyle(fontSize: 20),),
              SizedBox(height: 6,),
              Text("you answered ${widget.correct} answers correctly and ${widget.incorrect} answers incorrectly",style: TextStyle(fontSize: 15,color: Colors.grey),textAlign: TextAlign.center,),
              SizedBox(height: 20,),
              GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: blueButton(context: context, lable: "Go Home"))
            ],
          ),
        ),
      ),

    );
  }
}
