import 'package:flutter/material.dart';
import 'package:provider_todo_app/utils/colors.dart';

import 'widges.dart';

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

