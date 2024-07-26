import 'dart:math';

import 'package:flutter/material.dart';

import '../model/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];

  String? taskName;
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  bool get isValid =>
      taskName != null &&
      dateController.text.isNotEmpty &&
      timeController.text.isNotEmpty;

  setTask(value) {
    taskName = value;
    print(taskName);
    notifyListeners();
  }

  setDate(DateTime? date) {
    if (date == null) {
      return;
    }
    DateTime currentDate = DateTime.now();
    DateTime now =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    // print(now);
    int differences = date.difference(now).inDays;
    print(differences);
    if (differences == 0) {
      dateController.text = "Today";
    } else if (differences == 1) {
      dateController.text = "Tommorrow";
    } else {
      dateController.text = "${date.day}-${date.month}-${date.year}";
    }
    notifyListeners();

    // print(date);
  }

  setTime(TimeOfDay? time) {
    print(time);
    if (time == null) {
      return;
    }
    if (time.hour == 0) {
      timeController.text = "12:${time.minute} AM";
    } else if (time.hour < 12) {
      timeController.text = "${time.hour}:${time.minute} AM";
    } else if (time.hour == 12) {
      timeController.text = "${time.hour}:${time.minute} PM";
    } else {
      timeController.text = "${time.hour - 12}:${time.minute} PM";
    }
    notifyListeners();
  }

  addTask() {
    if (!isValid) {
      return;
    }
    final task = TaskModel(taskName!, dateController.text, timeController.text);
    timeController.clear();
    dateController.clear();
    tasks.add(task);
    notifyListeners();
  }
}
