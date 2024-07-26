import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo_app/model/task_model.dart';
import 'package:provider_todo_app/provider_viewmodel/task_viewmodel.dart';

import '../utils/colors.dart';

//Custom List Tile
class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.taskModel,
  });
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      
      title: Text(
        taskModel.taskName,
        style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 17,
            fontWeight: FontWeight.w500),
      ),
      subtitle: Text("${taskModel.date}  ${taskModel.time}",
          style: TextStyle(
              color: AppColors.textColor,
              fontSize: 13,
              fontWeight: FontWeight.w300)),
    );
  }
}
//Custom Floating Button

class CustomFAB extends StatelessWidget {
  const CustomFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 5,
      shape: const CircleBorder(),
      backgroundColor: AppColors.primaryColor,
      onPressed: () {
        double sh = MediaQuery.sizeOf(context).height;
        double sw = MediaQuery.sizeOf(context).width;
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(sh: sh, sw: sw, bottomInset: bottomInset);
            });
      },
      child: Icon(
        Icons.add,
        size: 35,
        color: AppColors.whiteColor,
      ),
    );
  }
}
//Custom Dialog Box

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.sh,
    required this.sw,
    required this.bottomInset,
  });

  final double sh;
  final double sw;
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return Dialog(
      backgroundColor: AppColors.secondaryColor,
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          height: sh * 0.55,
          width: sw * 0.9,
          child: Padding(
            padding: EdgeInsets.only(
                left: sw * 0.08,
                right: sw * 0.08,
                top: sh * 0.02,
                bottom: bottomInset > 0 ? bottomInset : sh * 0.02),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: bottomInset),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "New Task",
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 22),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "What has to be done?",
                    style: TextStyle(fontSize: 13, color: AppColors.textColor),
                  ),
                  CustomTextField(
                    hint: "Enter a task",
                    onChanged: (value) {
                      taskProvider.setTask(value);
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Due Date",
                    style: TextStyle(fontSize: 13, color: AppColors.textColor),
                  ),
                  CustomTextField(
                    hint: "Enter a Date",
                    readOnly: true,
                    icon: Icons.calendar_month_outlined,
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2015),
                          lastDate: DateTime(2030),
                          initialDate: DateTime.now());
                      taskProvider.setDate(date);
                    },
                    controller: taskProvider.dateController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hint: "Enter a Time",
                    readOnly: true,
                    icon: Icons.timer,
                    onTap: () async {
                      // TODO: add function
                      TimeOfDay? time = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      taskProvider.setTime(time);
                    },
                    controller: taskProvider.timeController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.whiteColor),
                        onPressed: () {
                          taskProvider.addTask();
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Create",
                          style: TextStyle(color: AppColors.primaryColor),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
//Custom TextField

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hint,
      this.icon,
      this.onTap,
      this.readOnly = false,
      this.onChanged,
      this.controller});
  final String hint;
  final IconData? icon;
  final void Function()? onTap;
  final bool readOnly;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        style: TextStyle(color: AppColors.whiteColor),
        readOnly: readOnly,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: InkWell(
                onTap: onTap,
                child: Icon(
                  icon,
                  color: Colors.white,
                ))),
      ),
    );
  }
}
