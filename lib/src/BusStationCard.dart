import 'package:flutter/material.dart';

class BusStationCard extends StatefulWidget {
  final List<String> stationList;
  final int index;

  const BusStationCard({Key? key, required this.stationList, required this.index}) : super(key: key);

  @override
  State<BusStationCard> createState() => _BusStationCardState();
}

class _BusStationCardState extends State<BusStationCard> {
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
