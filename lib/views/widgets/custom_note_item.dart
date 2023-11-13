import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/cubit/notes_cubit.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/views/widgets/edit_notes_view.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({super.key, required this.note});

  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const EditNotesView(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color:Color(note.color),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 24, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(
                title:  Text(
                  note.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                  ),
                ),
                subtitle: Padding(
                  padding:  const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    note.subtitle,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 17,
                    ),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    note.delete();

                    BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                  },
                  icon: const Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.black,
                    size: 23,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                   note.date,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.4), fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
