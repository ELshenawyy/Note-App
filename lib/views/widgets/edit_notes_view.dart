import 'package:flutter/material.dart';
import 'package:note_app/model/note_model.dart';

import 'edit_notes_view_body.dart';

class EditNotesView extends StatelessWidget {
  const EditNotesView({super.key, required this.note});

  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditNotesViewBody(
        note: note,
      ),
    );
  }
}
