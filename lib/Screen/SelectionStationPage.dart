import 'package:busking/src/MyScrollBehavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:busking/ViewModel/StationViewModel.dart';
import 'package:busking/src/BusStationCard.dart';
import 'package:busking/model/Station.dart';

class SelectionStationPage extends StatelessWidget {
  final String routeId;

  const SelectionStationPage({Key? key, required this.routeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StationViewModel>(
        create: (_) => StationViewModel(routeId),
        child: StationPage(routeId: routeId)
    );
  }
}

class StationPage extends StatelessWidget {
  final String routeId;

  StationPage({Key? key, required this.routeId}) : super(key: key);

  late StationViewModel viewModel;
  late List<Station> station;
  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<StationViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("BusKing"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior: MyScrollBehavior(),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: viewModel.station.length,
                    itemBuilder: (context, index) {
                      return BusStationCard(
                        station: viewModel.station[index]
                      );},
                ),
              ),
            ),

            // TODO: 화면 하단 정류장 선택 결과 표시 부분
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: 150,
                        color: Colors.grey.shade400,
                        child: Center(child: Text(viewModel.start.stationName)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: 150,
                        color: Colors.grey.shade400,
                        child: Center(child: Text(viewModel.end.stationName)),
                      ),
                    )
                  ],
                ),
                TextButton(
                  onPressed: () {  },
                  child: Text("확인"),
                )
              ],
            )
          ],
        )
      ),
    );
  }
}

