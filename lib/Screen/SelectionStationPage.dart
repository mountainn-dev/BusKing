import 'package:busking/src/BusRouteCard.dart';
import 'package:busking/src/MyScrollBehavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:busking/model/BusRoute.dart';

class SelectionStationPage extends StatefulWidget {
  final String routeId;

  const SelectionStationPage({Key? key, required this.routeId}) : super(key: key);

  @override
  State<SelectionStationPage> createState() => _SelectionStationPageState();
}

class _SelectionStationPageState extends State<SelectionStationPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BusRoute.callStationList(widget.routeId),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
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
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return BusRouteCard(stationList: snapshot.data!, index: index);
                        }
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          return CupertinoActivityIndicator();
        }
      },
    );
  }
}
