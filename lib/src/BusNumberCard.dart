import 'package:flutter/material.dart';
import 'package:busking/Screen/SelectionStationPage.dart';

class BusNumberCard extends StatefulWidget {
  final List<String> busList;
  final int index;

  const BusNumberCard({Key? key, required this.busList, required this.index}) : super(key: key);

  @override
  State<BusNumberCard> createState() => _BusNumberCardState();
}

class _BusNumberCardState extends State<BusNumberCard> {
  final _editController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: ListTile(
          title: Text(widget.busList[widget.index],
          style: TextStyle(
            fontSize: 30
          ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SelectionStationPage(
                    routeId: widget.busList[widget.index]
                )
            ));
          },
        )
      ),
    );
  }
}
