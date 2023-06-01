import 'package:flutter/material.dart';
import 'package:busking/Screen/SelectionStationPage.dart';

class BusNumberCard extends StatefulWidget {
  final String routeName;
  final String routeId;

  const BusNumberCard({
    Key? key, required this.routeName, required this.routeId
  }) : super(key: key);

  @override
  State<BusNumberCard> createState() => _BusNumberCardState();
}

class _BusNumberCardState extends State<BusNumberCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: ListTile(
          title: Text(widget.routeName,
          style: TextStyle(
            fontSize: 30
          ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SelectionStationPage(
                    routeId: widget.routeId
                )
            ));
          },
        )
      ),
    );
  }
}
