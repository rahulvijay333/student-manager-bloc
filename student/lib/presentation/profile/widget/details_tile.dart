import 'package:flutter/material.dart';

class DetailsTileWidget extends StatelessWidget {
  const DetailsTileWidget(
      {super.key,
      required this.name,
      required this.age,
      required this.email,
      required this.rollno});

  final String name;
  final String age;
  final String email;
  final String rollno;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name: $name',
          style: const TextStyle(fontSize: 20),
        ),
      SizedBox(height: 15,),
        Text(
          'Age: $age',
          style: const TextStyle(fontSize: 20),
        ),   SizedBox(height: 15,),
        Text(
          'Email: $email',
          style: const TextStyle(fontSize: 20),
        ),
           SizedBox(height: 15,),
        Text(
         'Roll No: $rollno',
          style: const TextStyle(fontSize: 20),
        )
      ],
    );
  }
}
