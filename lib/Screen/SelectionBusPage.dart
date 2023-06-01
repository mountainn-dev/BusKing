import 'package:busking/ViewModel/BusRouteViewModel.dart';
import 'package:busking/model/BusRoute.dart';
import 'package:busking/src/BusNumberCard.dart';
import 'package:flutter/material.dart';
import 'package:busking/src/MyScrollBehavior.dart';
import 'package:provider/provider.dart';

class SelectionBusPage extends StatelessWidget {

  SelectionBusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BusRouteViewModel(),
      child: BusPage(),
    );
  }
}

class BusPage extends StatelessWidget {

  final _editController = TextEditingController();
  late BusRouteViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<BusRouteViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("BusKing"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _editController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "BusNumber"
              ),
            ),
            TextButton(
                onPressed: () {
                  viewModel.setKeyword(_editController.text);
                  context.read<BusRouteViewModel>().loadBus();
                },
                child: Text(
                  "확인"
                )),
            (viewModel.bus.isNotEmpty) ? Expanded(
              child: ScrollConfiguration(
                behavior: MyScrollBehavior(),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: viewModel.bus.length,
                    itemBuilder: (context, index) {
                      return BusNumberCard(
                          routeName: viewModel.bus[index].routeName,
                          routeId: viewModel.bus[index].routeId
                      );
                    }
                ),
              ),
            ) : Text("hello")
          ],
        ),
      ),
    );
  }
}
