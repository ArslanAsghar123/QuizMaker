import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/Widget/Widgets.dart';
import 'package:quiz_maker/Widget/quiz_play_widget.dart';
import 'package:quiz_maker/model/question_model.dart';
import 'package:quiz_maker/services/db.dart';
import 'package:quiz_maker/view/result.dart';

class QuizPlay extends StatefulWidget {
  final String quizId;

  QuizPlay(this.quizId);


  @override
  _QuizPlayState createState() => _QuizPlayState();
}

int total = 0;
int _correct = 0;
int _inCorrect = 0;
int _notAttempt = 0;

class _QuizPlayState extends State<QuizPlay> {

  DatabaseService databaseService = DatabaseService();
  QuerySnapshot questionSnapshot;
  QuestionModel getQuestionModelFromDatasnapshot(DocumentSnapshot questionSnapshot){
    QuestionModel questionModel = QuestionModel();
    questionModel.question =questionSnapshot.data()["Question"];

    List<String> options =[
      questionSnapshot.data()["option1"],
      questionSnapshot.data()["option2"],
      questionSnapshot.data()["option3"],
      questionSnapshot.data()["option4"],


    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctAnswer = questionSnapshot.data()["option1"];
    questionModel.answered = false;
    return questionModel;

  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getRealQuizData(widget.quizId).then((value){
      questionSnapshot = value;
      _notAttempt = 0;
      _correct = 0;
      _inCorrect = 0;
      // ignore: deprecated_member_use
      total = questionSnapshot.documents.length;
      print("$total this is total");
      setState(() {

      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0.0,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black54),
        brightness: Brightness.light,
      ),
      body: Container(
        child: Column(
          children: [
            // ignore: deprecated_member_use
            questionSnapshot == null ? Container(child: Center(child: CircularProgressIndicator(),),):ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 24),
              shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                // ignore: deprecated_member_use
                itemCount: questionSnapshot.documents.length,
                itemBuilder: (context , index){
                  // ignore: deprecated_member_use
                  return QuizPlayTile(questionModel:getQuestionModelFromDatasnapshot(questionSnapshot.documents[index]),
                  index: index,);

            })
          ],
        ),
      ),
floatingActionButton: FloatingActionButton(
child: Icon(Icons.check),
  onPressed: (){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Result(
      correct: _correct,
      incorrect: _inCorrect,
      total: total,

    )));
  },
),
    );
  }
}
class QuizPlayTile extends StatefulWidget {

  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({this.questionModel,this.index});
  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelect ='';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text("Q${widget.index+1}  ${widget.questionModel.question}",style: TextStyle(
          fontSize: 18.0,color:Colors.black87
        ),),
        SizedBox(height: 14.0,),
        GestureDetector(
          onTap: (){
            if(!widget.questionModel.answered){
              if(widget.questionModel.option1 == widget.questionModel.correctAnswer){
                optionSelect = widget.questionModel.option1;
                widget.questionModel.answered = true;
                _correct =_correct + 1;
                _notAttempt = _notAttempt - 1;
                setState(() {

                });
              }else{
                optionSelect = widget.questionModel.option1;
                widget.questionModel.answered =true;
                _inCorrect = _inCorrect + 1;
                _notAttempt = _notAttempt - 1;
                setState(() {

                });
              }
            }

          },
          child: Optiontile(
            correctAnswer: widget.questionModel.correctAnswer,
            description: widget.questionModel.option1,
            option: 'A',
            optionalSelect: optionSelect,
          ),
        ),
        SizedBox(height: 4.0,),
        GestureDetector(
          onTap: (){
            if(!widget.questionModel.answered){
              if(widget.questionModel.option2 == widget.questionModel.correctAnswer){
                optionSelect = widget.questionModel.option2;
                widget.questionModel.answered = true;
                _correct =_correct + 1;
                _notAttempt = _notAttempt - 1;
                setState(() {

                });
              }else{
                optionSelect = widget.questionModel.option2;
                widget.questionModel.answered =true;
                _inCorrect = _inCorrect + 1;
                _notAttempt = _notAttempt - 1;
                setState(() {

                });
              }
            }
          },
          child: Optiontile(
            correctAnswer: widget.questionModel.correctAnswer,
            description: widget.questionModel.option2,
            option: 'B',
            optionalSelect: optionSelect,
          ),
        ),
        SizedBox(height: 4.0,),
        GestureDetector(
          onTap: (){
            if(!widget.questionModel.answered){
              if(widget.questionModel.option3 == widget.questionModel.correctAnswer){
                optionSelect = widget.questionModel.option3;
                widget.questionModel.answered = true;
                _correct =_correct + 1;
                _notAttempt = _notAttempt - 1;
                setState(() {

                });
              }else{
                optionSelect = widget.questionModel.option3;
                widget.questionModel.answered =true;
                _inCorrect = _inCorrect + 1;
                _notAttempt = _notAttempt - 1;
                setState(() {

                });
              }
            }

          },
          child: Optiontile(
            correctAnswer: widget.questionModel.correctAnswer,
            description: widget.questionModel.option3,
            option: 'C',
            optionalSelect: optionSelect,
          ),
        ),
        SizedBox(height: 4.0,),
        GestureDetector(
          onTap: (){
            if(!widget.questionModel.answered){
              if(widget.questionModel.option4 == widget.questionModel.correctAnswer){
                optionSelect = widget.questionModel.option4;
                widget.questionModel.answered = true;
                _correct =_correct + 1;
                _notAttempt = _notAttempt - 1;
                setState(() {

                });
              }else{
                optionSelect = widget.questionModel.option4;
                widget.questionModel.answered =true;
                _inCorrect = _inCorrect + 1;
                _notAttempt = _notAttempt - 1;
                setState(() {

                });
              }
            }
          },
          child: Optiontile(
            correctAnswer: widget.questionModel.correctAnswer,
            description: widget.questionModel.option4,
            option: 'D',
            optionalSelect: optionSelect,
          ),
        ),
        SizedBox(height: 16.0,)


      ],),
    );
  }
}


