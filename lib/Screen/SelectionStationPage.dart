import 'package:busking/src/MyScrollBehavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:busking/ViewModel/StationViewModel.dart';
import 'package:busking/src/BusStationCard.dart';
import 'package:busking/src/UserStation.dart';

class SelectionStationPage extends StatelessWidget {
  final String routeId;

  const SelectionStationPage({Key? key, required this.routeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => StationViewModel(routeId),
        child: StationPage(routeId: routeId)
    );
  }
}

class StationPage extends StatelessWidget {
  final String routeId;

  const StationPage({Key? key, required this.routeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BusKing"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                 Expanded(
                  child: ScrollConfiguration(
                    behavior: MyScrollBehavior(),
                    child: Consumer<StationViewModel>(
                      builder: (context, viewModel, _) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: viewModel.station.length,
                          itemBuilder: (context, index) {
                            return BusStationCard(
                                station: viewModel.station[index]
                            );},
                        );
                      },
                      child: ListView(),
                    ),
                  ),
                ),
            // TODO: 화면 하단 정류장 선택 결과 표시 부분
            Consumer<StationViewModel>(
                builder: (context, viewModel, _) {
                  return UserStation(viewModel: viewModel);
                })
          ],
        )
      ),
    );
  }
}



