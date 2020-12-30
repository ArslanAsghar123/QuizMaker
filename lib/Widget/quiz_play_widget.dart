import 'package:flutter/material.dart';

class Optiontile extends StatefulWidget {
  final String option, description, correctAnswer, optionalSelect;

  Optiontile(
      {@required this.option,@required this.description,@required this.correctAnswer,@required this.optionalSelect});

  @override
  _OptiontileState createState() => _OptiontileState();
}

class _OptiontileState extends State<Optiontile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.description == widget.optionalSelect
                        ? widget.optionalSelect == widget.correctAnswer
                            ? Colors.green.withOpacity(0.7)
                            : Colors.red.withOpacity(0.7)
                        : Colors.grey,width: 1.4),
            borderRadius: BorderRadius.circular(30)
            ),
            alignment: Alignment.center,
            child: Text("${widget.option}",style: TextStyle(
              color: widget.optionalSelect == widget.description?widget.correctAnswer == widget.optionalSelect
    ? Colors.green.withOpacity(0.7)
        : Colors.red.withOpacity(0.7)
        : Colors.grey)
            ),),
          SizedBox(width: 6.0,),
          Text(widget.description ,style: TextStyle(
            fontSize: 16, color: Colors.grey
          ),),

        ],
      ),
    );
  }
}
