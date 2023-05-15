import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student/application/home/home_bloc.dart';
import 'package:student/application/insert/insert_bloc.dart';
import 'package:student/application/search/search_bloc.dart';
import 'package:student/domain/core/di/di_dart.dart';
import 'package:student/domain/db_model/db_mode.dart';
import 'package:student/presentation/edit/screen_edit.dart';
import 'package:student/presentation/home/home_screen.dart';

import 'presentation/home Page/welcome_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<HomeBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<InsertBloc>(),
          ),
          BlocProvider(create: (context) => getIt<SearchBloc>())
        ],
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          home: HomeScreen(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
