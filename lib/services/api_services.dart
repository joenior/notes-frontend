import 'dart:convert';
import 'package:notes/models/Notes.dart';
import 'package:http/http.dart' as http;

class APIService {
  static String _baseURL = "http://192.168.100.20:2222/notes";

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse(_baseURL + "/add");
    var response = await http.post(requestUri, body: note.toMap());
    print(jsonDecode(response.body.toString()));
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse(_baseURL + "/delete");
    var response = await http.post(requestUri, body: note.toMap());
    print(jsonDecode(response.body.toString()));
  }

  static Future<void> updateNote(Note note) async {
    Uri requestUri = Uri.parse(_baseURL + "/update");
    var response = await http.post(requestUri, body: note.toMap());
    print(jsonDecode(response.body.toString()));
  }

  static Future<List<Note>> fetchNote(String userID) async {
    Uri requestUri = Uri.parse(_baseURL + "/list");
    var response = await http.post(requestUri, body: {"userID": "AA"});
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
    List<Note> notes = [];
    for (var noteMap in decoded) {
      notes.add(Note.fromMap(noteMap));
    }
    return notes;
  }
}
