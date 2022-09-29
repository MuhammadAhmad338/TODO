// ignore_for_file: file_names
import "package:flutter/material.dart";
import 'package:local_database/Utils/myButton.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;

  const DialogBox({Key? key, required this.controller, required this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: SizedBox(
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
                controller: controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Add a new task")),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  text: "Submit",
                  onPressed: onSubmit,
                ),
                const SizedBox(width: 10),
                MyButton(
                  text: "Cancel",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
