import 'package:flutter/material.dart';
import 'AddStudentPage.dart';
import 'GPACalculator.dart';

class Student {
  String name;
  List<double> subjectMarks;

  Student({required this.name, required this.subjectMarks});
}

class DashboardPage extends StatefulWidget {
  final List<Student> students;

  DashboardPage({required this.students});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Student> sortedStudents = [];

  @override
  void initState() {
    super.initState();
    sortStudents();
  }

  // Sort method in descending order
  void sortStudents() {
    sortedStudents = List.from(widget.students);
    sortedStudents.sort((a, b) {
      double gpaA = GPACalculator.calculateGPA(a.subjectMarks);
      double gpaB = GPACalculator.calculateGPA(b.subjectMarks);
      return gpaB.compareTo(gpaA);
    });
  }

  void _deleteStudent(Student student) {
    setState(() {
      widget.students.remove(student);
      sortStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GPA CALCULATOR',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Students GPA',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            if (sortedStudents.isEmpty)
              Text(
                'No Added Student Data.',
                style: TextStyle(fontSize: 16.0),
              )
            else
              Column(
                children: sortedStudents.map((student) {
                  double gpa = GPACalculator.calculateGPA(student.subjectMarks);

                  return Card(
                    color: Colors.blue[50],
                    elevation: 3.0,
                    child: ListTile(
                      title: Text(student.name),
                      subtitle: Text(
                        'GPA: ${gpa.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => _deleteStudent(student),
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          // Go to the Add Student page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddStudentPage(students: widget.students),
            ),
          ).then((newStudent) {
            if (newStudent != null) {
              setState(() {
                widget.students.add(newStudent);
                sortStudents();
              });
            }
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
