import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/application/home/home_bloc.dart';
import 'package:student/domain/db_model/db_mode.dart';
import 'package:student/presentation/edit/screen_edit.dart';
import 'package:student/presentation/home/home_screen.dart';
import 'package:student/presentation/profile/widget/details_tile.dart';

class ScreenProfile extends StatelessWidget {
  ScreenProfile({super.key, required this.student, this.fromSearch = false});

  final StudentModel student;
  final bool fromSearch;

  @override
  Widget build(BuildContext context) {
    final imageString = student.imageUrl!;
    final ima = File(imageString);
    final xfile = XFile(ima.path);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
        ),
        body: Container(
          // color: Colors.amber.shade200,
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                height: 280,
                // color: Colors.redAccent.withOpacity(0.5),
                child: Center(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: FileImage(File(xfile.path)),
                  ),
                ),
              ),
              DetailsTileWidget(
                age: student.age,
                email: student.emailId,
                name: student.name,
                rollno: student.rollNo,
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        //----------------------------------------------------------------edit

                        //------------------------------------------------------
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) {
                              return ScreenEdit(student: student, xfile: xfile);
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit_document),
                      label: const Text('Edit')),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton.icon(
                      onPressed: () {
                        //--------------------------------------------------------delete
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Alert'),
                              content: const Text('Do you want to delete ?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      BlocProvider.of<HomeBloc>(context)
                                          .add(DeleteStudent(key: student.id));
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                        builder: (context) {
                                          return const HomeScreen();
                                        },
                                      ), (route) => false);
                                    },
                                    child: const Text('Yes')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No'))
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80.0, right: 80),
                child: ElevatedButton(
                    onPressed: () {
                      //---------------------------------close function

                      Navigator.of(context).pop();
                    },
                    child: const Text('close')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
