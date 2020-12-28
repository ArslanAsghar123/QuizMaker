import 'package:flutter/material.dart';
import 'package:quiz_maker/Widget/Widgets.dart';
import 'package:quiz_maker/services/db.dart';
import 'package:quiz_maker/view/addQuestion.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();

  String quizImgUrl, quizTitle, quizdescription, quizId;
  DatabaseService databaseService = new DatabaseService();

  bool _isLoading = false;

  createQuizOnline() async {
    if (_formKey.currentState.validate()) {
      quizId = randomAlphaNumeric(16);
      setState(() {
        _isLoading = true;
      });

      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgUrl": quizImgUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizdescription,
      };
      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AddQuestion(quizId)));
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
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter Image Url' : null,
                      decoration: InputDecoration(hintText: 'Quiz Image Url'),
                      onChanged: (val) {
                        quizImgUrl = val;
                      },
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter Quiz Title' : null,
                      decoration: InputDecoration(hintText: 'Quiz Title'),
                      onChanged: (val) {
                        quizTitle = val;
                      },
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter Quiz Description' : null,
                      decoration: InputDecoration(hintText: 'Quiz Description'),
                      onChanged: (val) {
                        quizdescription = val;
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        createQuizOnline();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30)),
                        width: MediaQuery.of(context).size.width - 48,
                        alignment: Alignment.center,
                        child: Text(
                          'Creat Quiz',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ),
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
