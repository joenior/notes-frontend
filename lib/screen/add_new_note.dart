// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:notes/models/Notes.dart';
import 'package:notes/provider/list_provider.dart';

class AddNewNotePage extends StatefulWidget {
  const AddNewNotePage({
    Key? key,
    required this.isUpdate,
    this.note,
  }) : super(key: key);
  final bool isUpdate;
  final Note? note;

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void addNewNote() {
    Note newNote = Note(
        id: const Uuid().v1(),
        userID: "AA",
        title: titleController.text,
        content: contentController.text,
        dateAdded: DateTime.now());

    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
  }

  FocusNode noteFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                widget.isUpdate
                    ? Provider.of<NotesProvider>(context, listen: false)
                        .updateNode(widget.note!.copyWith(
                            title: titleController.text,
                            content: contentController.text))
                    : addNewNote();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              autofocus: widget.isUpdate ? false : true,
              controller: titleController,
              onSubmitted: (val) {
                if (val.isNotEmpty) {
                  noteFocus.requestFocus();
                }
              },
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
              ),
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                maxLines: null,
                focusNode: noteFocus,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write here!",
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
