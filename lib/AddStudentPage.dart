import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddStudentPage extends StatefulWidget {
  final List<Student> students;

  AddStudentPage({required this.students});

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  TextEditingController _studentNameController = TextEditingController();
  List<TextEditingController> _subjectMarkControllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize to 5 subjects
    for (int i = 0; i < 5; i++) {
      _subjectMarkControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in _subjectMarkControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _studentNameController,
              decoration: InputDecoration(
                labelText: 'Student Name',
                border: OutlineInputBorder(),

              ),
            ),
            SizedBox(height: 15.0),
            Text('Subject Marks',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,),
              textAlign: TextAlign.center,
            ),
            Padding(padding:EdgeInsetsDirectional.all(10)),
            Column(
              children: List.generate(5, (index) {
                return TextFormField(
                  controller: _subjectMarkControllers[index],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Subject ${index + 1} Mark',
                    border: OutlineInputBorder(),
                  ),

                );
              }),
            ),

            SizedBox(height: 20.0),
            Padding(padding: EdgeInsets.symmetric(vertical: 10),),
            ElevatedButton(
              onPressed: () {
                // Add the new student to the list
                String studentName = _studentNameController.text;
                List<double> subjectMarks = _subjectMarkControllers
                    .map((controller) => double.tryParse(controller.text) ?? 0.0)
                    .toList();
                if (studentName.isNotEmpty) {
                  Student newStudent = Student(name: studentName, subjectMarks: subjectMarks);
                  Navigator.pop(context, newStudent);
                }
              },
              child: Text('Add Student'),
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
                padding: EdgeInsets.symmetric(vertical: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
