import 'package:flutter/material.dart';

class BusRouteCard extends StatefulWidget {
  final List<String> stationList;
  final int index;

  const BusRouteCard({Key? key, required this.stationList, required this.index}) : super(key: key);

  @override
  State<BusRouteCard> createState() => _BusRouteCardState();
}

class _BusRouteCardState extends State<BusRouteCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
          child: ListTile(
            title: Text(widget.stationList[widget.index],
              style: TextStyle(
                  fontSize: 10
              ),
            ),
            onTap: () {
            },
          )
      ),
    );
  }
}
