import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sum_app/ui/controllers/cancelled_task_controller.dart';
import 'package:sum_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:sum_app/ui/widgets/snack_bar_message.dart';
import 'package:sum_app/ui/widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final CancelledTaskController _cancelledTaskController =
      Get.put(CancelledTaskController());
  final CancelledTaskController cancelledTaskController =
      Get.find<CancelledTaskController>();

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CancelledTaskController>(builder: (controller) {
      return Visibility(
        visible: controller.inProgress == false,
        replacement: const CenteredCircularProgressIndicator(),
        child: RefreshIndicator(
          onRefresh: () async {
            _getCancelledTaskList();
          },
          child: Center(
            child: ListView.separated(
              itemCount: _cancelledTaskController.cancelledTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: _cancelledTaskController.cancelledTaskList[index],
                  onRefreshList: _getCancelledTaskList,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            ),
          ),
        ),
      );
    });
  }

  Future<void> _getCancelledTaskList() async {
    final bool result = await cancelledTaskController.getCompletedTaskList();

    if (!result) {
      showSnackBarMessage(context, "Failed to load!");
    }
  }
}
