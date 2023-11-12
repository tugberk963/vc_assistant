import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommandsContainer extends StatelessWidget {
  const CommandsContainer({required this.commandTitle, required this.commandDetails, required this.bgColor, super.key});

  final String commandTitle;
  final String commandDetails;
  final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(commandTitle, style: GoogleFonts.montserrat(fontSize: 24),),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(commandDetails, style: GoogleFonts.montserrat(fontSize: 14),)
                  ],
                ),
              ),
            ),
          );
  }
}