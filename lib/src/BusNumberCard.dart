import 'package:flutter/material.dart';
import 'package:busking/Screen/SelectionStationPage.dart';

class BusNumberCard extends StatelessWidget {
  final String routeName;
  final String routeId;

  const BusNumberCard({
    Key? key, required this.routeName, required this.routeId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: ListTile(
          title: Text(routeName,
          style: TextStyle(
            fontSize: 30
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
