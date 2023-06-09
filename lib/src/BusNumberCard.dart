import 'package:flutter/material.dart';
import 'package:busking/Screen/SelectionStationPage.dart';
import 'package:busking/model/Bus.dart';

class BusNumberCard extends StatelessWidget {
  final Bus bus;

  const BusNumberCard({Key? key, required this.bus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: ListTile(
          // 버스명, 버스 기-종점
          title: Text("${bus.routeName} (${bus.startStationName} - ${bus.endStationName})",
          style: TextStyle(
            fontSize: 20
          ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SelectionStationPage(
                    routeId: bus.routeId
                )
            ));
          },
        )
      ),
    );
  }
}
