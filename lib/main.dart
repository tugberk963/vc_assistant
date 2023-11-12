import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vc_assistant/commands_container.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Voice Assistant',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[100],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text('A.V.A.'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset(
              'assets/vc_assistant.png',
              height: 100,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Ai Text Container
          ShapeOfView(
            shape: BubbleShape(
                position: BubblePosition.Top,
                arrowPositionPercent: 0.5,
                borderRadius: 15,
                arrowHeight: 10,
                arrowWidth: 10),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'How can I help you today ?',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
          // commands title container
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Text(
                'Here are few commands you can try: ',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // CHAT GPT CONTAINER
          CommandsContainer(
            commandTitle: "ChatGPT",
            commandDetails:
                "A smarter way to stay organized and informed with ChatGPT.",
            bgColor: Colors.blue[100],
          ),
          const SizedBox(
            height: 20,
          ),
          CommandsContainer(
            commandTitle: "Dall-E",
            commandDetails:
                'Get inspired and stay creative with your personel assistant powered by Dall-E.',
            bgColor: Colors.blue[200],
          ),
          const SizedBox(
            height: 20,
          ),
          CommandsContainer(
            commandTitle: "Smart Voice Assistant",
            commandDetails:
                'Get the best of both worlds with a voice asisstan powered by Dall-E and ChatGPT.',
            bgColor: Colors.blue[400],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.mic),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
