import 'package:flutter/material.dart';
import 'package:notes/services/api_services.dart';

import '../models/Notes.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];
  bool isLoading = true;

  NotesProvider() {
    fetchNotes();
  }
  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
    APIService.addNote(note);
  }

  void updateNode(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    notifyListeners();
    APIService.updateNote(note);
  }

  void deleteNode(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    notifyListeners();
    APIService.deleteNote(note);
  }

  void fetchNotes() async {
    notes = await APIService.fetchNote("AA");
    isLoading = false;

    notifyListeners();
  }
}
