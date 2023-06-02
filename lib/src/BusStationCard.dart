import 'package:flutter/material.dart';

class BusStationCard extends StatelessWidget {
  final String stationName;
  final String stationId;

  const BusStationCard({
    Key? key, required this.stationName, required this.stationId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
          child: ListTile(
            title: Text(stationName,
              style: TextStyle(
                  fontSize: 30
              ),
            ),
            onTap: () {
            },
          )
      ),
    );
  }
}
