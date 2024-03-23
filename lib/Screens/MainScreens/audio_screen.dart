import 'package:flutter/material.dart';
import 'package:kidspace/Services/audio.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  @override
  void initState() {
    AudioService().getAudioStory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('All Audio Items Will Be Available Here.'));
  }
}