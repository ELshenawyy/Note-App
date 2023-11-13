import 'package:flutter/material.dart';

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

  List<Color> colors = [
    const Color(0xffBCECE0),
    const Color(0xff36EEE0),
    const Color(0xffF652A0),
    const Color(0xff4C5270),
    const Color(0xff406350),
    const Color(0xffE54330),
    const Color(0xffF8EA8C),
  ];

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
                currentIndex = index;
                setState(() {});
              },
              child: ColorItem(
                colors: colors[index],
                isActive: currentIndex == index,
              ),
            ),
          );
        },
        itemCount: colors.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
