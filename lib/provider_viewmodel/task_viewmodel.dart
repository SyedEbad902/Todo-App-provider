import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];

  // ignore: non_constant_identifier_names
  Delete(int index) {
    tasks.removeAt(index);
    List<String> tasksList =
        tasks.map((tassk) => jsonEncode(tassk.toJson())).toList();
    sp.setStringList("myList", tasksList);
    sp.setStringList('myList', tasksList);
    notifyListeners();
  }

  late SharedPreferences sp;
  // ignore: non_constant_identifier_names
  SPinstance() async {
    sp = await SharedPreferences.getInstance();
    readSharedpref();
  }

  readSharedpref() {
    List<String>? taskList = sp.getStringList('myList');
    if (taskList != null) {
      tasks = taskList
          .map((tassk) => TaskModel.fromJson(json.decode(tassk)))
          .toList();
    }
    notifyListeners();
  }

  String? taskName;
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  bool get isValid =>
      taskName != null &&
      dateController.text.isNotEmpty &&
      timeController.text.isNotEmpty;

  setTask(value) {
    taskName = value;
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
    final task = TaskModel(
        taskName: taskName!,
        date: dateController.text,
        time: timeController.text);
    timeController.clear();
    dateController.clear();
    tasks.insert(0,task);
    List<String> tasksList =
        tasks.map((tassk) => jsonEncode(tassk.toJson())).toList();
    sp.setStringList("myList", tasksList);
    notifyListeners();
  }
}
