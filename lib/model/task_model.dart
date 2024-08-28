class TaskModel {
  String taskName;
  String date;
  String time;
  TaskModel({ required this.taskName,required this.date,required this.time});

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        taskName: json["taskName"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "taskName": taskName,
        "date": date,
        "time": time,
      };
  
}
