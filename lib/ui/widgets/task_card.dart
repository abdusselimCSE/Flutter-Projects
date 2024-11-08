import 'package:flutter/material.dart';
import 'package:sum_app/data/models/network_response.dart';
import 'package:sum_app/data/models/task_model.dart';
import 'package:sum_app/data/service/network_caller.dart';
import 'package:sum_app/data/utils/urls.dart';
import 'package:sum_app/ui/utils/app_colors.dart';
import 'package:sum_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:sum_app/ui/widgets/snack_bar_message.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.onRefreshList,
  });

  final TaskModel taskModel;
  final VoidCallback onRefreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String _selectedStatus = '';
  bool _chnageStatusInProgress = false;
  bool _deletTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title ?? "",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              widget.taskModel.description ?? "",
            ),
            Text(
              "Date: ${widget.taskModel.createdDate ?? ""}",
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTaskStatusChip(),
                Wrap(
                  children: [
                    Visibility(
                      visible: _chnageStatusInProgress == false,
                      replacement: CenteredCircularProgressIndicator(),
                      child: IconButton(
                        onPressed: _onTapEditButton,
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                    Visibility(
                      visible: _deletTaskInProgress == false,
                      replacement: const CenteredCircularProgressIndicator(),
                      child: IconButton(
                        onPressed: _onTapDeleteButton,
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // Edit button
  void _onTapEditButton() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Status"),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              children: ['New', 'Completed', 'Cancelled', 'Progress'].map((e) {
                return ListTile(
                  onTap: () {
                    _changeStatus(e);
                    Navigator.pop(context);
                  },
                  title: Text(e),
                  selected: _selectedStatus == e,
                  trailing: _selectedStatus == e ? Icon(Icons.check) : null,
                );
              }).toList()),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
          ],
        );
      },
    );
  }

  Future<void> _onTapDeleteButton() async {
    _deletTaskInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.deleteTask(widget.taskModel.sId!));

    if (response.isSuccess) {
      widget.onRefreshList();
    } else {
      _deletTaskInProgress = false;
      showSnackBarMessage(context, response.errorMessage);
    }
  }

  // Task Status Chip
  Widget _buildTaskStatusChip() {
    return Chip(
      label: Text(
        widget.taskModel.status!,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      side: const BorderSide(
        color: AppColors.themeColor,
      ),
    );
  }

  Future<void> _changeStatus(String newStatus) async {
    _chnageStatusInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.changedStatus(widget.taskModel.sId!, newStatus));

    if (response.isSuccess) {
      widget.onRefreshList();
    } else {
      _chnageStatusInProgress = false;
      showSnackBarMessage(context, response.errorMessage);
    }
  }
}
