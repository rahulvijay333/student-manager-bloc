import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/application/search/search_bloc.dart';
import 'package:student/presentation/profile/profile_screen.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController seachField = TextEditingController();

    //------------search initial page called
    BlocProvider.of<SearchBloc>(context).add(SearchInitial());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Student'),centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.deepPurple)),
                  hintText: 'Search Students...'),
              controller: seachField,
              onChanged: (value) {
                //-----------------------------------------------------search event here
                BlocProvider.of<SearchBloc>(context)
                    .add(SearchQuery(searchQuery: value));
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state.initialList.isEmpty) {
                  return const Center(
                    child: Text('No Records Avalaible'),
                  );
                } else if (state.searchList.isNotEmpty) {
                  return ListView.builder(
                    itemCount: state.searchList.length,
                    itemBuilder: (context, index) {
                      final imageString = state.searchList[index].imageUrl!;
                      final ima = File(imageString);
                      final xfile = XFile(ima.path);

                      return GestureDetector(
                        onTap: () {
                          //----------------------------------------------------screen_profile
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (ctx1) {
                              return ScreenProfile(
                                student: state.searchList[index],
                                fromSearch: true,
                              );
                            },
                          ));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: FileImage(File(xfile.path)),
                          ),
                          title: Text(state.searchList[index].name),
                        ),
                      );
                    },
                  );
                  //----------------------------------------else condition
                } else if (state.searchList.isEmpty &&
                    seachField.text.isEmpty) {
                  return ListView.builder(
                    itemCount: state.initialList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          //-------------------------------------------------search prfile
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (ctx1) {
                              return ScreenProfile(
                                student: state.initialList[index],
                                fromSearch: true,
                              );
                            },
                          ));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: FileImage(File(imageConvert(
                                    url: state.initialList[index].imageUrl!)
                                .path)),
                          ),
                          title: Text(state.initialList[index].name),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Student not found',
                      style: TextStyle(fontSize: 25),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  XFile imageConvert({required String url}) {
    final ima = File(url);
    final xfile = XFile(ima.path);

    return xfile;
  }
}
