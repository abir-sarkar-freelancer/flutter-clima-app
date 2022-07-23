import 'dart:io';

void taks1() {
  String result = "task 1 data";
  print('Task 1 complete');
}

Future<String> task2() async {
  Duration threeSeconds = const Duration(seconds: 5);
  String result = "nothing";
  await Future.delayed(threeSeconds, () {
    result = "task 2 data";
    print("Task 2 complete");
  });

  return result;
}

void task3(String task2result) {
  String result = "task 3 data";
  print("Task 3 complete $task2result");
}

void performTask() async {
  taks1();
  String task2result = await task2();
  task3(task2result);
}

void main() {
  performTask();
}
