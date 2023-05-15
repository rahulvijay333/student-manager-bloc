
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/application/home/home_bloc.dart';
import 'package:student/domain/db_model/db_mode.dart';
import 'package:student/presentation/add/screen_add.dart';
import 'package:student/presentation/edit/screen_edit.dart';
import 'package:student/presentation/profile/profile_screen.dart';
import 'package:student/presentation/search/screen_search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(DisplayStudents());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Students List'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const ScreenSearch();
              },));
              
            }, icon: const Icon(Icons.search))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            //-----------------------------------------------------insert section
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const ScreenAdd();
              },
            ));
          },
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.loading == true) {
              return  Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children:const [
                    CircularProgressIndicator(),
                    Text('Loading....')
                  ],
                ),
              );
            }

            if (state.studentList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.no_accounts),
                    Text('Student Database Empty'),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final imageString = state.studentList[index].imageUrl!;
                    final ima = File(imageString);
                    final xfile = XFile(ima.path);

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 80,
                        color: Colors.deepPurple.shade100,
                        child: GestureDetector(
                          onTap: () {
                            //------------------------------------------------------profile route
                            final StudentModel student =
                                state.studentList[index];

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return ScreenProfile(
                                  student: student,
                                );
                              },
                            ));
                          },
                          child: ListTile(
                            leading: state.studentList[index].imageUrl == null
                                ? const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/default_image.png',),
                                  )
                                : CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        FileImage(File(xfile.path)),
                                  ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.studentList[index].name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  state.studentList[index].rollNo,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    //--------------------------edit screen
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return ScreenEdit(
                                            student: state.studentList[index],
                                            xfile: xfile);
                                      },
                                    ));
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    //-----------------------------------------delete bloc call

                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Alert'),
                                          content: const Text(
                                              'Do you want to delete ?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  BlocProvider.of<HomeBloc>(
                                                          context)
                                                      .add(DeleteStudent(
                                                          key: state
                                                              .studentList[
                                                                  index]
                                                              .id));
                                                  Navigator.of(context).pop();
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: state.studentList.length),
            );
          },
        ),
      ),
    );
  }
}
