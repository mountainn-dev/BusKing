import 'package:flutter/material.dart';
import 'package:busking/Screen/SelectionStationPage.dart';

class BusNumberCard extends StatelessWidget {
  final String routeName;
  final String routeId;
  final String startStationName;
  final String endStationName;

  const BusNumberCard({
    Key? key,
    required this.routeName, required this.routeId,
    required this.startStationName, required this.endStationName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: ListTile(
          title: Text("$routeName ($startStationName - $endStationName)",
          style: TextStyle(
            fontSize: 20
          ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SelectionStationPage(
                    routeId: routeId
                )
            ));
          },
        )
      ),
    );
  }
}
