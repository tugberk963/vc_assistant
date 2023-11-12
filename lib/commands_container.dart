import 'package:flutter/material.dart';

class CommandsContainer extends StatelessWidget {
  const CommandsContainer({required this.commandTitle, required this.commandDetails,super.key});

  final String commandTitle;
  final String commandDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(commandTitle),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(commandDetails)
                  ],
                ),
              ),
            ),
          );
  }
}