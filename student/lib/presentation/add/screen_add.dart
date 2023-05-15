import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/application/home/home_bloc.dart';
import 'package:student/application/insert/insert_bloc.dart';
import 'package:student/domain/db_model/db_mode.dart';
import 'package:student/presentation/home/home_screen.dart';

class ScreenAdd extends StatefulWidget {
  const ScreenAdd({super.key});

  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
  bool profilePresent = true;
  //textfield controller
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _emailController = TextEditingController();

  final _rollNoController = TextEditingController();

  //form validation key
  final _formkey = GlobalKey<FormState>();

  //-------------------------xfile handling image path
  XFile? _image;
  XFile? prev;

  //image picker function
  getImage() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Upload Image from ?'),
          actions: [
            TextButton(
                onPressed: () async {
                  final image = await ImagePicker.platform
                      .getImage(source: ImageSource.gallery);
                  setState(() {
                    if (image == null) {
                      _image = prev;
                    } else {
                      _image = image;
                    }

                    Navigator.of(context).pop();
                  });
                },
                child: const Text('Gallery')),
            TextButton(
                onPressed: () async {
                  final image = await ImagePicker.platform
                      .getImage(source: ImageSource.camera);
                  setState(() {
                    if (image == null) {
                      _image = prev;
                    } else {
                      _image = image;
                    }
                    Navigator.of(context).pop();
                  });
                },
                child: const Text('Camera')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Student'),
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
                    SizedBox(
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
                            return 'Age Field Empty';
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
                            return 'Roll No Field Empty';
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
                            return 'Email Field Empty';
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

                          final imagepath = _image?.path;

                          final studentDetails = StudentModel(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              name: name,
                              age: age,
                              emailId: email,
                              rollNo: rollNo,
                              imageUrl: imagepath);

                          if (_formkey.currentState!.validate() &&
                              _image != null) {
                            //---------------------------------------------------insert event
                            BlocProvider.of<InsertBloc>(context)
                                .add(InsertStudent(student: studentDetails));

                            //----------------------------------------------------display refresh
                            BlocProvider.of<HomeBloc>(context)
                                .add(DisplayStudents());

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
                        child: const Text('Add')),
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
