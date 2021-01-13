import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/Widget/Widgets.dart';
import 'package:quiz_maker/services/db.dart';
import 'package:quiz_maker/view/quiz.dart';
import 'package:quiz_maker/view/quiz_play.dart';
import 'package:quiz_maker/view/signin.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream quizStream;

  DatabaseService databaseService = new DatabaseService();



  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
              shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return QuizTile(
                      imgUrl: snapshot.data.documents[index].data()['quizImgUrl'],
                      title: snapshot.data.documents[index].data()["quizTitle"],
                      desc: snapshot.data.documents[index].data()["quizDesc"],
                      quizid: snapshot.data.documents[index].data()["quizId"],
                    );
                  });
        },
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        actions: [
          IconButton(
            icon: Icon(Icons.logout,color: Colors.black,),
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
            },
          )
        ],
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String quizid;

  QuizTile({@required this.imgUrl,@required this.title,@required this.desc,@required this.quizid});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizPlay(
        quizid
        )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height:  150,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(imgUrl,width: MediaQuery.of(context).size.width - 48,fit: BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black26,

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [Text(title,style: TextStyle(
                  fontSize: 17,color:Colors.white,fontWeight: FontWeight.w500
                ),), Text(desc,style: TextStyle(
                fontSize: 12,color:Colors.white,fontWeight: FontWeight.w400))],
              ),
            )
          ],
        ),
      ),
    );
  }
}
