import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../constants.dart';
import '../model/note_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());
  fetchAllNotes() async {
    try {
      var noteBox = Hive.box<NoteModel>(kNotesBox);
      emit(NotesSuccess(noteBox.values.toList()));
    } catch (e) {
      emit(
        NotesFailure(e.toString()),
      );
    }
  }
}
