import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../model/note_model.dart';
import 'colors_list_view.dart';

class EditNotesViewColor extends StatefulWidget {
  const EditNotesViewColor({super.key, required this.note});

  final NoteModel note;

  @override
  State<EditNotesViewColor> createState() => _EditNotesViewColorState();
}

class _EditNotesViewColorState extends State<EditNotesViewColor> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = KColors.indexOf(
      Color(widget.note.color),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38 * 2,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: GestureDetector(
              onTap: () {
                widget.note.color = KColors[index].value;
                currentIndex = index;
                setState(() {});
              },
              child: ColorItem(
                colors: KColors[index],
                isActive: currentIndex == index,
              ),
            ),
          );
        },
        itemCount: KColors.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
