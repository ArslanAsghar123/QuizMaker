import 'package:flutter/material.dart';

class Optiontile extends StatefulWidget {
  final String option, description, correctAnswer, optionalSelect;

  Optiontile(
      {this.option, this.description, this.correctAnswer, this.optionalSelect});

  @override
  _OptiontileState createState() => _OptiontileState();
}

class _OptiontileState extends State<Optiontile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.description == widget.optionalSelect
                        ? widget.optionalSelect == widget.correctAnswer
                            ? Colors.green.withOpacity(0.7)
                            : Colors.red.withOpacity(0.7)
                        : Colors.grey)),
            child: Text("${widget.option}",style: TextStyle(
              color: widget.optionalSelect == widget.description?widget.correctAnswer == widget.optionalSelect
    ? Colors.green.withOpacity(0.7)
        : Colors.red.withOpacity(0.7)
        : Colors.grey)
            ),),
          SizedBox(width: 6.0,),
          Text(widget.description ,style: TextStyle(
            fontSize: 17, color: Colors.grey
          ),),

        ],
      ),
    );
  }
}
