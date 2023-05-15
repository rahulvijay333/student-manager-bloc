import 'package:flutter/material.dart';
import 'package:student/presentation/add/screen_add.dart';
import 'package:student/presentation/home/home_screen.dart';
import 'package:student/presentation/search/screen_search.dart';

class ScreenMenuHome extends StatelessWidget {
  const ScreenMenuHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Student Management App'),
        centerTitle: true,
      ),
      backgroundColor: Colors.deepPurple.shade100,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  //----------------------------------------------------view all students
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const HomeScreen();
                    },
                  ));
                },
                child: const ViewStudentTile()),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
                onTap: () {
                  //----------------------------------------------------add  students
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return ScreenAdd();
                    },
                  ));
                },
                child: const AddStudentTile()),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
                //--------------------------------------------------------search student
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const ScreenSearch();
                    },
                  ));
                },
                child: const SearchTile())
          ],
        ),
      ),
    ));
  }
}

class SearchTile extends StatelessWidget {
  const SearchTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 180,
      decoration: BoxDecoration(
          color: Colors.deepPurple, borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Search Student',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Icon(
            Icons.search,
            size: 50,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class AddStudentTile extends StatelessWidget {
  const AddStudentTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 180,
      decoration: BoxDecoration(
          color: Colors.deepPurple, borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Add Student',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Icon(
            Icons.group_add,
            size: 50,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class ViewStudentTile extends StatelessWidget {
  const ViewStudentTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 180,
      decoration: BoxDecoration(
          color: Colors.deepPurple, borderRadius: BorderRadius.circular(25)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'View Students',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Icon(
              Icons.groups_3,
              size: 50,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
