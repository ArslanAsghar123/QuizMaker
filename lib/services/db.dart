import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addQuizData(Map quizData, String quizId) async {
    // ignore: deprecated_member_use
    await Firestore.instance
        .collection("quiz")
        // ignore: deprecated_member_use
        .document(quizId)
        // ignore: deprecated_member_use
        .setData(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questionData, String quizId) async {
    // ignore: deprecated_member_use
    await Firestore.instance
        .collection("quiz")
        // ignore: deprecated_member_use
        .document(quizId)
        .collection('QNA')
        .add(questionData)
        .catchError((e) {
      print(e);
    });
  }

  getQuizData() async {
    return await Firestore.instance
        .collection("quiz")
        .snapshots();
  }
}
