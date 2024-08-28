import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo_app/provider_viewmodel/task_viewmodel.dart';
import 'package:provider_todo_app/utils/colors.dart';

import 'widges.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}
// @override

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // Use Future.microtask to ensure it runs after build context is ready
      Provider.of<TaskProvider>(context, listen: false).SPinstance()();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.secondaryColor,
        floatingActionButton: const CustomFAB(),
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Row(
            children: [
              CircleAvatar(
                radius: 17,
                backgroundColor: AppColors.whiteColor,
                child: Icon(
                  Icons.check,
                  size: 20,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "To Do List",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor),
              ),
            ],
          ),
        ),
        body: taskProvider.tasks.isNotEmpty
            ? ListView.separated(
                itemBuilder: (context, index) {
                  final showTask = taskProvider.tasks[index];
                  return CustomListTile(
                    taskModel: showTask,
                    index: index,
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 1.5,
                    thickness: 1,
                    color: AppColors.textColor,
                  );
                },
                itemCount: taskProvider.tasks.length)
            : Container(
                color: AppColors.secondaryColor,
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Add To Do",
                    style: TextStyle(fontSize: 17, color: AppColors.textColor),
                  ),
                ),
              ));
  }
}
