import 'package:busking/src/BusNumberCard.dart';
import 'package:flutter/material.dart';
import 'package:busking/src/MyScrollBehavior.dart';

class SelectionBusPage extends StatefulWidget {
  final List<String> busList;
  final List<String> routeIdList;

  const SelectionBusPage({Key? key, required this.busList, required this.routeIdList}) : super(key: key);

  @override
  State<SelectionBusPage> createState() => _SelectionBusPageState();
}

class _SelectionBusPageState extends State<SelectionBusPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ScrollConfiguration(
              behavior: MyScrollBehavior(),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.busList.length,
                  itemBuilder: (context, index) {
                    return BusNumberCard(busList: widget.busList, routeIdList: widget.routeIdList, index: index);
                  }
              ),
            ),
          ),
        )
      ],
    );
  }


}
