import 'package:flutter/material.dart';
import 'package:busking/model/Station.dart';

class BusStationCard extends StatelessWidget {
  final Station station;

  const BusStationCard({
    Key? key,
    required this.station
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
          child: ListTile(
            title: Text(station.stationName,
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            onTap: () {
            },
          )
      ),
    );
  }
}
