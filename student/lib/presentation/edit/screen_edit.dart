import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/application/home/home_bloc.dart';
import 'package:student/application/insert/insert_bloc.dart';
import 'package:student/application/search/search_bloc.dart';
import 'package:student/domain/db_model/db_mode.dart';
import 'package:student/presentation/home/home_screen.dart';

class ScreenEdit extends StatefulWidget {
  ScreenEdit(
      {super.key,
      required this.student,
      required this.xfile,
      this.fromSearchPage = false});

  final StudentModel student;
  final XFile xfile;
  bool fromSearchPage;

  @override
  State<ScreenEdit> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenEdit> {
  bool profilePresent = true;
  //textfield controller
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _emailController = TextEditingController();

  final _rollNoController = TextEditingController();

  //form validation key
  final _formkey = GlobalKey<FormState>();

  XFile? _image;
  XFile? prev;

  //image function
  getImage() async {
    final image =
       
        await ImagePicker.platform.getImage(source: ImageSource.gallery);

    setState(() {
      if (image == null) {
        _image = prev;
      } else {
        _image = image;
      }
    });
  }

  @override
  void initState() {
    _nameController.text = widget.student.name;
    _ageController.text = widget.student.age;
    _emailController.text = widget.student.emailId;
    _rollNoController.text = widget.student.rollNo;
    _image = widget.xfile;
    super.initState();
  }

  //image picker object
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Student'),
          centerTitle: true,
        ),
        body: BlocBuilder<InsertBloc, InsertState>(
          builder: (context, state) {
            return Container(
              // color: Colors.amber.shade200,
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formkey,
                child: ListView(
                  children: [
                    Container(
                        width: double.infinity,
                        height: 200,
                        // color: Colors.redAccent.withOpacity(0.5),
                        child: _image == null
                            ? const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/default_image.png'),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: FileImage(File(_image!.path)),
                              )),
                    IconButton(
                        onPressed: () {
                          prev = _image;

                          getImage();
                        },
                        icon: const Icon(Icons.add_a_photo)),
                    Visibility(
                      visible: !profilePresent,
                      child: const SizedBox(
                        height: 30,
                        child: Center(
                            child: Text(
                          'Profile Pic Empty',
                          style: TextStyle(color: Colors.red),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name Field Empty';
                          } else {
                            return null;
                          }
                        },
                        controller: _nameController,
                        decoration: const InputDecoration(
                            hintText: 'Name', border: OutlineInputBorder())),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name Field Empty';
                          } else {
                            return null;
                          }
                        },
                        controller: _ageController,
                        decoration: const InputDecoration(
                            hintText: 'Age', border: OutlineInputBorder())),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name Field Empty';
                          } else {
                            return null;
                          }
                        },
                        controller: _rollNoController,
                        decoration: const InputDecoration(
                            hintText: 'Roll No', border: OutlineInputBorder())),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name Field Empty';
                          } else {
                            return null;
                          }
                        },
                        controller: _emailController,
                        decoration: const InputDecoration(
                            hintText: 'Email ', border: OutlineInputBorder())),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          //--------------------------------------insert function
                          final name = _nameController.text;
                          final age = _ageController.text;
                          final email = _emailController.text;
                          final rollNo = _rollNoController.text;

                          // final imageBy = await _image!.readAsBytes();

                          final imagepath = _image?.path;

                          final studentDetails = StudentModel(
                              id: widget.student.id,
                              name: name,
                              age: age,
                              emailId: email,
                              rollNo: rollNo,
                              imageUrl: imagepath);

                          if (_formkey.currentState!.validate() &&
                              _image != null) {
                            BlocProvider.of<HomeBloc>(context).add(EditStudent(
                                key: widget.student.id,
                                student: studentDetails));

                            Navigator.of(context).pop();
                          } else {
                            if (_image == null) {
                              setState(() {
                                profilePresent = false;
                              });
                            } else {
                              profilePresent = true;
                            }
                          }
                        },
                        child: const Text('Save')),
                    ElevatedButton(
                        //----------------------------------------close function
                        onPressed: () {
                          Navigator.of(context).pop(
                            MaterialPageRoute(
                              builder: (context) {
                                return const HomeScreen();
                              },
                            ),
                          );
                        },
                        child: const Text('Close'))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
