import 'package:flutter/material.dart';
import 'package:provider_todo_app/utils/colors.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: ListView.separated(
          itemBuilder: (context, index) {
            return const CustomListTile();
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1.5,
              thickness: 1,
              color: AppColors.textColor,
            );
          },
          itemCount: 5),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      title: Text(
        "Ebad",
        style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 17,
            fontWeight: FontWeight.w600),
      ),
      subtitle: Text("Tommorrow,   2:12",
          style: TextStyle(
              color: AppColors.textColor,
              fontSize: 13,
              fontWeight: FontWeight.w300)),
    );
  }
}

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
    return Dialog(
      backgroundColor: AppColors.secondaryColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                  const CustomTextField(
                    hint: "Enter a task",
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
                    onTap: () {
                      // TODO: add function
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hint: "Enter a Time",
                    readOnly: true,
                    icon: Icons.timer,
                    onTap: () {
                      // TODO: add function
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.whiteColor),
                        onPressed: () {},
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

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hint,
      this.icon,
      this.onTap,
      this.readOnly = false});
  final String hint;
  final IconData? icon;
  final void Function()? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
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
