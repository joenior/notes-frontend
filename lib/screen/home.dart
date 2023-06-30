import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/provider/list_provider.dart';
import 'package:notes/screen/add_new_note.dart';
import 'package:provider/provider.dart';

import '../models/Notes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: notesProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: notesProvider.notes.length > 0
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: notesProvider.notes.length,
                      itemBuilder: (context, index) {
                        Note currentNote = notesProvider
                            .notes[notesProvider.notes.length - index - 1];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => AddNewNotePage(
                                          isUpdate: true,
                                          note: currentNote,
                                        )));
                          },
                          onLongPress: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 160,
                                    decoration: const BoxDecoration(
                                      // color: whiteColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: Center(
                                        child: Column(children: [
                                          Text(
                                            "Are you sure, you want to delete this node permanently?",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                notesProvider
                                                    .deleteNode(currentNote);
                                                Navigator.pop(context);
                                              },
                                              child: Text("Yes, Delete",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)))
                                        ]),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.grey,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentNote.title!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      currentNote.content!,
                                      style: const TextStyle(fontSize: 16),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ]),
                            ),
                          ),
                        );
                      })
                  : Center(
                      child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "No Notes Created. Create your first note by clicking on the + button.",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => AddNewNotePage(
                        isUpdate: false,
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
