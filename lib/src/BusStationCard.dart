import 'package:busking/ViewModel/StationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:busking/model/Station.dart';
import 'package:provider/provider.dart';

class BusStationCard extends StatelessWidget {
  final Station station;

  const BusStationCard({
    Key? key,
    required this.station
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StationViewModel>(context);
    var color = (viewModel.start.stationName.compareTo(station.stationName) == 0)
        ? Colors.yellow
        : (viewModel.end.stationName.compareTo(station.stationName) == 0)
        ? Colors.orange
        : Colors.white;
    return Card(
      color: color,
      child: Center(
          child: ListTile(
            title: Text(station.stationName,
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            onTap: () {
              viewModel.setUserStation(station);
            },
          )
      ),
    );
  }
}
