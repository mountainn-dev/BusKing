import 'package:busking/ViewModel/BusRouteViewModel.dart';
import 'package:busking/src/BusNumberCard.dart';
import 'package:flutter/material.dart';
import 'package:busking/src/MyScrollBehavior.dart';
import 'package:provider/provider.dart';

class SelectionBusPage extends StatefulWidget {

  const SelectionBusPage({Key? key}) : super(key: key);

  @override
  State<SelectionBusPage> createState() => _SelectionBusPageState();
}

class _SelectionBusPageState extends State<SelectionBusPage> {
  final _editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BusRouteViewModel(),
      child: Scaffold(
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
                  onPressed: () {},
                  child: Text(
                    "확인"
                  )),
              Expanded(
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
              )
            ],
          ),
        ),
      ),
    );
  }


}
