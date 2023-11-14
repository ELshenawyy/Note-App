import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubit/add_note_cubit.dart';

import '../../constants.dart';

class ColorItem extends StatelessWidget {
  const ColorItem({super.key, required this.isActive, required this.colors});

  final bool isActive;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return isActive
        ? CircleAvatar(
            radius: 38,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 34,
              backgroundColor: colors,
            ),
          )
        : CircleAvatar(
            radius: 36,
            backgroundColor: colors,
          );
  }
}

class ListColorItems extends StatefulWidget {
  const ListColorItems({super.key});

  @override
  State<ListColorItems> createState() => _ListColorItemsState();
}

class _ListColorItemsState extends State<ListColorItems> {
  int currentIndex = 0;

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
                BlocProvider.of<AddNoteCubit>(context).color = KColors[index];
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
