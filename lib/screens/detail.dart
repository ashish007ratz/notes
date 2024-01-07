import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Note note = ModalRoute.of(context)!.settings.arguments as Note;

    return Scaffold(
      appBar: AppBar(
        title: const  Text('Note Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit note page
              // You can implement this functionality here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              note.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

