// Define events
import 'package:bloc/bloc.dart';

import '../models/note.dart';

/// events

abstract class NoteEvent {}

class AddNote extends NoteEvent {
  final Note note;

  AddNote(this.note);
}

class DeleteNote extends NoteEvent {
  final int id;

  DeleteNote(this.id);
}

class FetchNotes extends NoteEvent {}

class GetNote extends NoteEvent {
  final int id;

  GetNote(this.id);
}

// state
class NotesState {
  final List<Note> notes;

  NotesState(this.notes);
}

// Define BLoC
class NoteBloc extends Bloc<NoteEvent, NotesState> {
  NoteBloc() : super(NotesState([])) {
    on<FetchNotes>((event, emit) {
      emit(NotesState(Note.fetchNotes()));
    });
    on<AddNote>((event, emit) {
      event.note.addOrUpdateNote();
          emit(NotesState(Note.fetchNotes()));

      }
    );

    on<DeleteNote>((event, emit) {
          Note(id: event.id, title: '',description: '').deleteNote();
          emit(NotesState(Note.fetchNotes()));
        });

    on<GetNote>((event, emit) {
        try {
          final note = Note.getNote(event.id);
          emit(NotesState([note]));
        } catch (e) {
          print('Note not found: $e');
        }
    });
  }

}


  @override
  Stream<NotesState> mapEventToState(NoteEvent event) async* {
    if (event is AddNote) {
      event.note.addOrUpdateNote();
      yield NotesState(Note.fetchNotes());
    } else if (event is DeleteNote) {
      // Note.deleteNoteById(event.id);
      yield NotesState(Note.fetchNotes());
    } else if (event is GetNote) {
      try {
        final note = Note.getNote(event.id);
        yield NotesState([note]);
      } catch (e) {
        print('Note not found: $e');
      }
    }
  }

