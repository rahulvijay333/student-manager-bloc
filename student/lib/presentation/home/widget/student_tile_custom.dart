import 'package:flutter/material.dart';

class StudentTileCustom extends StatelessWidget {
  const StudentTileCustom({
    super.key,
    required this.name,
    required this.roll,
  });

  final String name;
  final String roll;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple.withOpacity(0.5),
      child: ListTile(
        title: Text(name),
        leading: CircleAvatar(),
        subtitle: Text(roll),
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
      ),
    );
  }
}
