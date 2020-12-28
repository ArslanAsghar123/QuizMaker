import 'package:flutter/material.dart';
import 'package:quiz_maker/Widget/Widgets.dart';
import 'package:quiz_maker/services/db.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;

  AddQuestion(this.quizId);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  DatabaseService databaseService = DatabaseService();

  bool _isLoading = false;
  uploadQuestionData(){
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      Map<String,String> questionMap ={
        "Question": question,
        "option1": option1,

        "option2": option2,
        "option3": option3,
        "option4": option4,



      };
      databaseService.addQuestionData(questionMap, widget.quizId).then((value) {
        setState(() {
          _isLoading = false;
        });

      });

    }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0.0,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),

      body:_isLoading? Container(
        child: Center(child: CircularProgressIndicator(),),
      ) :Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter Question' : null,
                decoration: InputDecoration(hintText: 'Question'),
                onChanged: (val) {
                  question = val;
                },
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter option' : null,
                decoration:
                    InputDecoration(hintText: 'option1 (Correct option)'),
                onChanged: (val) {
                  option1 = val;
                },
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter option2' : null,
                decoration: InputDecoration(hintText: 'option2'),
                onChanged: (val) {
                  option2 = val;
                },
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter option 3' : null,
                decoration: InputDecoration(hintText: 'option3'),
                onChanged: (val) {
                  option3 = val;
                },
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter option4' : null,
                decoration: InputDecoration(hintText: 'option4'),
                onChanged: (val) {
                  option4 = val;
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    alignment: Alignment.center,
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      uploadQuestionData();

                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)),
                      width: MediaQuery.of(context).size.width / 2 - 24,
                      alignment: Alignment.center,
                      child: Text(
                        'Add Question',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 30.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
