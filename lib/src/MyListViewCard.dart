import 'package:flutter/material.dart';

class MyListViewCard extends StatefulWidget {
  final List<String> busList;
  final int index;

  const MyListViewCard({Key? key, required this.busList, required this.index}) : super(key: key);

  @override
  State<MyListViewCard> createState() => _MyListViewCardState();
}

class _MyListViewCardState extends State<MyListViewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: ListTile(
          title: Text(widget.busList[widget.index],
          style: TextStyle(
            fontSize: 30
          ),
          )
        )
      ),
    );
  }
}
