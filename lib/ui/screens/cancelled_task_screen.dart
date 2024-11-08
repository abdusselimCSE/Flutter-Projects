import 'package:flutter/material.dart';

class CancelledTaskScreen extends StatelessWidget {
  const CancelledTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
          // return TaskCard();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
      ),
    );
  }
}
