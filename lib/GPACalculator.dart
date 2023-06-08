import 'package:cloud_firestore/cloud_firestore.dart';

class GPACalculator {
  static double calculateGPA(List<double> subjectMarks) {
    double totalMarks = subjectMarks.reduce((value, element) => value + element);
    int totalSubjects = subjectMarks.length;
    double gpa = totalMarks  / totalSubjects;
    return gpa;

  }


}
