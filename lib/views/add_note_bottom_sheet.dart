import 'package:flutter/cupertino.dart';
import 'package:note_app/views/custom_text_field.dart';

class AddNoteBottomSheet extends StatelessWidget {
  const AddNoteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(
            height: 32,
          ),
          AddTextField(
            hint: 'title',
          ),
          SizedBox(
            height: 16,
          ),
          AddTextField(
            hint: 'content',
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
