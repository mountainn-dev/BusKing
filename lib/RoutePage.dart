import 'package:busking/src/MyListViewCard.dart';
import 'package:flutter/material.dart';
import 'package:busking/src/MyScrollBehavior.dart';

class RoutePage extends StatefulWidget {
  final List<String> busList;

  const RoutePage({Key? key, required this.busList}) : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ScrollConfiguration(
              behavior: MyScrollBehavior(),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.busList.length,
                  itemBuilder: (context, index) {
                    return MyListViewCard(busList: widget.busList, index: index);
                  }
              ),
            ),
          ),
        )
      ],
    );
  }
}
