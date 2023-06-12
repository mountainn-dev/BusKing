import 'package:flutter/material.dart';
import 'package:busking/ViewModel/StationViewModel.dart';

// 정류장 선택 페이지 하단 사용자 정류장 표시 위젯
class UserStation extends StatelessWidget {
  const UserStation({super.key, required this.viewModel});

  final StationViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Row(
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
                // 사용자 선택 출발 정류장
                child: Center(child: (viewModel.isStartSelected)
                    ? Text(viewModel.start.stationName)
                    : Text("")
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: 150,
                color: Colors.grey.shade400,
                // 사용자 선택 도착 정류장
                child: Center(child: (viewModel.isEndSelected)
                    ? Text(viewModel.end.stationName)
                    : Text("")
                ),
              ),
            )
          ],
        ),
        TextButton(
          onPressed: () {  },
          child: const Text("확인"),
        )
      ],
    );
  }
}