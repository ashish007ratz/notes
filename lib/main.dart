import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_application/screens/note_list.dart';
import 'controller/controller.dart';
import 'models/note.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  notesBox = await Hive.openBox('notes_box');
  runApp(NotesApp());
}



class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteBloc(),
      child: GetMaterialApp(
        theme: ThemeData(
          // Define your theme here
          // For example:
          primarySwatch: Colors.blue,
        ),
        home: NotesHomePage(),
      ),
    );
  }
}



