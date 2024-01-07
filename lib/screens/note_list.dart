import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:notes_application/screens/create.dart';
import '../controller/controller.dart';
import '../models/note.dart';

class _NotesHomePageState extends State<NotesHomePage> {
  late NoteBloc noteBloc;
  @override
  void initState() {
    noteBloc = BlocProvider.of<NoteBloc>(context);
    noteBloc.add(FetchNotes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async{
                await Get.to(AddNotePage());
                // notes = Note.fetchNotes();
              },
            ),
          ],
        ),
        body:

        BlocBuilder<NoteBloc, NotesState>(
            builder: (context, state) {
              final notes = state.notes;
           return  notes.isEmpty
               ? noNotes()
               : ListView.builder(
             itemCount: notes.length,
             itemBuilder: (context, index) {
               return NoteTile(
                 note: notes[index],
                 onTap: () {
                   var note = notes[index];
                   showMenu<String>(
                     color: Colors.deepPurpleAccent.withOpacity(0.5),
                     context: context,
                     position: RelativeRect.fromLTRB(100, 100, 0, 0),
                     items: <PopupMenuEntry<String>>[
                       PopupMenuItem<String>(
                         value: 'Update',
                         child: Text('Update', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black54),),
                         onTap: (){
                           Get.to(AddNotePage(id: note.id));
                         },
                       ),
                       PopupMenuItem<String>(
                         value: 'Delete',
                         child: Text('Delete', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black54),),
                         onTap: (){
                           noteBloc = BlocProvider.of<NoteBloc>(context);
                           noteBloc.add(FetchNotes());
                         },
                       ),
                     ],
                     elevation: 8.0,
                   );
                 },
               );
             },
           );
         }
       )
      );
      }
  }

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

  Widget noNotes() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...const [
            Text("No Notes Display",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black)),
            SizedBox(height: 15),
            Text(
              "You  need to add notes to display notes here",
              style: TextStyle(fontSize: 12, color: Colors.black)
            ),
            SizedBox(height: 15)
          ],
          ElevatedButton(
            onPressed: () async{
              await Get.to(AddNotePage());
              // notes = Note.fetchNotes();
            },
            style: ElevatedButton.styleFrom(
              elevation: 1, // Change the elevation as needed
              padding:const EdgeInsets.only(left: 15,right: 15, bottom: 5,top: 5), // Padding around the button content
              primary: Colors.greenAccent.withOpacity(0.2), // Button background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add,color: Colors.white), // Your icon
                SizedBox(width: 8), // Adjust the space between icon and text
                Text(
                  'Add Note', // Your title
                  style: TextStyle(fontSize: 16, color: Colors.white), // Text style
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

class NoteTile extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;

  NoteTile({required this.note, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        // Define proper colors and padding for the card here
        child: ListTile(
          title: Text(
            note.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            note.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
