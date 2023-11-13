import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:vc_assistant/commands_container.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vc_assistant/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:animate_do/animate_do.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final stt = SpeechToText();
  String lastWords = '';
  OpenAIServices openAIServices = OpenAIServices();
  FlutterTts tts = FlutterTts();
  String? generatedImg;
  String? generatedContent;

  int animate_start = 200;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

/* Text to speech */
  Future<void> initTextToSpeech() async {
    setState(() {});
  }

  Future<void> sysSpeak(String content) async {
    await tts.speak(content);
  }
/* Text to speech ends */

/* Speech to text */
  Future<void> initSpeechToText() async {
    await stt.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await stt.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await stt.stop();
    setState(() {});
  }

  Future<void> onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }
/* Speech to text ends */

  @override
  void dispose() {
    super.dispose();
    stt.stop();
    tts.stop();
  }

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
        title: BounceInDown(child: const Text('A.V.A.')),
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
          Visibility(
            visible: generatedImg == null,
            child: ShapeOfView(
              shape: BubbleShape(
                  position: BubblePosition.Top,
                  arrowPositionPercent: 0.5,
                  borderRadius: 15,
                  arrowHeight: 10,
                  arrowWidth: 10),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  generatedContent ?? "Hi, I'm A.V.A. your virtual assistant.",
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),

          // dall - e prompt if user asks for img
          if (generatedImg != null)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(generatedImg!),
              ),
            ),
          // dall -e prompt ends
          // commands title container
          Visibility(
            visible: generatedContent == null && generatedImg == null,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Text(
                  'Here are some commands you can try:',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          // CHAT GPT CONTAINER
          SlideInLeft(
            delay: Duration(milliseconds: animate_start*3),
            child: Visibility(
              visible: generatedContent == null && generatedImg == null,
              child: CommandsContainer(
                commandTitle: "ChatGPT",
                commandDetails:
                    "A smarter way to stay organized and informed with ChatGPT.",
                bgColor: Colors.blue[100],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SlideInLeft(
            delay: Duration(milliseconds: animate_start*5),
            child: Visibility(
              visible: generatedContent == null && generatedImg == null,
              child: CommandsContainer(
                commandTitle: "Dall-E",
                commandDetails:
                    'Get inspired and stay creative with your personel assistant powered by Dall-E.',
                bgColor: Colors.blue[200],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SlideInLeft(
            delay: Duration(milliseconds: animate_start*7),
            child: Visibility(
              visible: generatedContent == null && generatedImg == null,
              child: CommandsContainer(
                commandTitle: "Smart Voice Assistant",
                commandDetails:
                    'Get the best of both worlds with a voice asisstan powered by Dall-E and ChatGPT.',
                bgColor: Colors.blue[400],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await stt.hasPermission && stt.isNotListening) {
            await startListening();
          } else if (stt.isListening) {
            var speech = await openAIServices.isAskingImg(
                lastWords); // checkin what user wanted ? img : text.

            if (speech.contains("https")) {
              generatedImg = speech;
              generatedContent = null;
              setState(() {});
            } else {
              generatedContent = speech;

              generatedImg = null;
              await sysSpeak(speech);
              setState(() {});
            }
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        child: ZoomIn(child: Icon(stt.isListening ? Icons.stop : Icons.mic)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
