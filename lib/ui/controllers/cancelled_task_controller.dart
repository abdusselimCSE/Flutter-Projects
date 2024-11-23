import 'package:get/get.dart';
import 'package:sum_app/data/models/network_response.dart';
import 'package:sum_app/data/models/task_list_model.dart';
import 'package:sum_app/data/models/task_model.dart';
import 'package:sum_app/data/service/network_caller.dart';
import 'package:sum_app/data/utils/urls.dart';

class CancelledTaskController extends GetxController {
  bool _getCancelledTaskListInProgress = false;
  String? _errorMessage;

  bool get inProgress => _getCancelledTaskListInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> _cancelledTaskList = [];
  List<TaskModel> get cancelledTaskList => _cancelledTaskList;

  Future<bool> getCompletedTaskList() async {
    bool isSuccess = false;
    _cancelledTaskList.clear();
    _getCancelledTaskListInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.cancelledTaskList);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _cancelledTaskList = taskListModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getCancelledTaskListInProgress = false;
    update();
    return isSuccess;
  }
}
