import 'package:busking/ViewModel/StationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:busking/model/Station.dart';
import 'package:provider/provider.dart';
import 'package:busking/ViewModel/CardViewModel.dart';

class BusStationCard extends StatelessWidget {
  final Station station;

  const BusStationCard({
    Key? key,
    required this.station
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StationViewModel>(context);
    return Card(
      color: viewModel.cardColor,
      child: Center(
          child: ListTile(
            title: Text(station.stationName,
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            onTap: () {
              viewModel.test();
            },
          )
      ),
    );
  }
}
